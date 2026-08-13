#!/bin/bash
exec >> /tmp/godot-runner.log 2>&1
export PATH=$PATH:/usr/bin:/usr/local/bin:/usr/sbin:/home/yigitkalan/.local/bin
FILE="$1"
TERM_CLASS="godot-helix-term"
SESSION_NAME="godot-helix"
HX_BIN=$(command -v helix || echo "/usr/sbin/helix")

if tmux has-session -t "$SESSION_NAME" 2>/dev/null; then
    # 1. Clear Helix's mode
    tmux send-keys -t "$SESSION_NAME" Escape Escape
    sleep 0.1

    # 2. Safely open the file (no quotes, Helix hates quotes in the :open command)
    tmux send-keys -t "$SESSION_NAME" ":open $FILE" Enter

    # 3. Find Hyprland's raw IPC socket in memory
    HYPR_SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket.sock"
    if [ ! -S "$HYPR_SOCKET" ]; then
        HYPR_SOCKET=$(find /tmp/hypr -name ".socket.sock" 2>/dev/null | head -n 1)
    fi

    # 4. Since Hyprland 0.55, the socket runs everything through its Lua VM.
    #    "dispatch <text>" gets wrapped as hl.dispatch(<text>), so <text>
    #    must be a real hl.dsp.* call, not the old "focuswindow class:X" string.
    LUA_CMD="dispatch hl.dsp.focus({ window = \"class:^(${TERM_CLASS})\$\" })"

    if command -v socat >/dev/null 2>&1; then
        echo -n "$LUA_CMD" | socat - UNIX-CONNECT:"$HYPR_SOCKET"
    else
        echo -n "$LUA_CMD" | nc -U "$HYPR_SOCKET"
    fi
else
    ghostty --class="$TERM_CLASS" -e bash -c "tmux new-session -s \"$SESSION_NAME\" '$HX_BIN \"$FILE\"'" &
fi
