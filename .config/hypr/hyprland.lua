-- Hyprland Lua config (0.55+)
-- Save as: ~/.config/hypr/hyprland.lua
-- Also place monitors.lua and workspaces.lua in ~/.config/hypr/

-- Each require() is a separate execution scope — an error in one
-- will NOT abort the rest of this file.
require("monitors")
require("workspaces")


--------------------
---- MY PROGRAMS ---
--------------------

local terminal    = "ghostty"
local menu        = os.getenv("HOME") .. "/.utils/launch_rofi.sh"
local emojis      = os.getenv("HOME") .. "/.utils/launch_emoji.sh"
local calculator  = os.getenv("HOME") .. "/.utils/launch_calculator.sh"
local clipboard   = os.getenv("HOME") .. "/.utils/launch_clipboard.sh"


--------------------
---- AUTOSTART -----
--------------------
-- Fires ONCE at boot, not on config reload.

hl.on("hyprland.start", function()
    hl.exec_cmd("waypaper --restore --backend hyprpaper")
    hl.exec_cmd("dunst")
    hl.exec_cmd(os.getenv("HOME") .. "/.utils/launch_waybar.sh")
    hl.exec_cmd("wl-paste -t text --watch clipman store --no-persist")
    hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("blueman-applet")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")
    hl.exec_cmd("xrandr --output DP-1 --primary")
    hl.exec_cmd("/usr/lib/hyprpolkitagent/hyprpolkitagent")
    hl.exec_cmd("rclone mount ProtonDrive: /mnt/ProtonDrive/")
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
end)

hl.on("config.reloaded", function()
    hl.exec_cmd("hyprsunset --temperature 4000")
    hl.exec_cmd("sh -c 'killall wayvibes; wayvibes " .. os.getenv("HOME") .. "/.config/wayvibes/my-new-sound -v 0.2'")
end)


hl.config({
    xwayland = {
        force_zero_scaling = true
    }
})

hl.config({
    misc = {
        vrr = 2 -- The '2' setting means it only activates in fullscreen games
    }
})



-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_SIZE",              "24")
hl.env("HYPRCURSOR_SIZE",           "24")
-- hl.env("LIBVA_DRIVER_NAME",         "iHD")
-- hl.env("GBM_BACKEND",               "iris")
-- hl.env("__GLX_VENDOR_LIBRARY_NAME", "mesa")
hl.env("WLR_NO_HARDWARE_CURSORS",   "1")
hl.env("WLR_DRM_NO_ATOMIC",         "1")

-- Wayland & Electron / Qt Fixes
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")
hl.env("QT_QPA_PLATFORM",              "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_WEBENGINE_CHROMIUM_FLAGS",  "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-gpu-rasterization --enable-zero-copy")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in          = 2,
        gaps_out         = 5,
        border_size      = 2,
        col = {
            active_border   = "#6B4DFF",
            
            -- Optional: give inactive windows a subtle border so they don't blend together
            inactive_border = "#7C7985",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },
})

hl.config({
    decoration = {
        rounding         = 0,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            render_power = 3,
            color        = 0xee1a1a1a,
        },
        blur = {
            enabled  = true,
            size     = 4,
            passes   = 2,
            vibrancy = 0.1696,
        },
    },
})

hl.config({
    animations = {
        enabled = false,
    },
})

-- REMOVED: dwindle.pseudotile — deleted in 0.55
hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status  = "master",
        orientation = "right",
    },
})

-- REMOVED: misc.vfr — moved to debug: in 0.55, don't set it
hl.config({
    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us,tr",
        kb_options = "grp:caps_toggle",
        kb_variant = "",
        kb_model   = "",
        kb_rules   = "",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll       = true,
            disable_while_typing = true,
            scroll_factor        = 0.6,
        },
    },
})

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})

hl.device({
    name        = "logitech-g305-1",
    sensitivity = -0.7,
})


---------------------
---- KEYBINDINGS ----
---------------------
-- If ANY line above this crashes at runtime, ALL binds below will be missing.
-- Each hl.config() call is isolated, so only the bad block fails.
-- Binds are all in one block — keep them error-free.

local mainMod = "SUPER"

hl.bind(mainMod .. " + Return",    hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q",         hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("hyprctl dispatch exit"))
hl.bind(mainMod .. " + F",         hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + V",         hl.dsp.window.float({ action = "toggle" }))

hl.bind(mainMod .. " + n",         hl.dsp.workspace.move({ monitor = "l" }))
hl.bind(mainMod .. " + m",         hl.dsp.workspace.move({ monitor = "r" }))

-- Keyboard Resizing (Fixed with relative = true)
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.resize({ x = 100,  y = 0,    relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.resize({ x = -100, y = 0,    relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.resize({ x = 0,    y = -100, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.resize({ x = 0,    y = 100,  relative = true }), { repeating = true })

hl.bind("XF86KbdLightOnOff",     hl.dsp.exec_cmd("brightnessctl --device='rgb:kbd_backlight' set 0"),    { locked = true })
hl.bind("XF86KbdBrightnessDown", hl.dsp.exec_cmd("brightnessctl --device='rgb:kbd_backlight' set 10%-"), { locked = true })
hl.bind("XF86KbdBrightnessUp",   hl.dsp.exec_cmd("brightnessctl --device='rgb:kbd_backlight' set 10%+"), { locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl --min-val=2 -q set 5%-"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -q set 5%+"),             { locked = true, repeating = true })

hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true })

hl.bind(mainMod .. " + SPACE",         hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + SHIFT + SPACE", hl.dsp.exec_cmd(emojis))
hl.bind(mainMod .. " + CTRL + SPACE",  hl.dsp.exec_cmd(clipboard))
hl.bind(mainMod .. " + ALT + SPACE",   hl.dsp.exec_cmd(calculator))

hl.bind(mainMod .. " + SHIFT + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(os.getenv("HOME") .. "/.utils/launch_waybar.sh"))

hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "d" }))

for i = 1, 10 do
    local key = tostring(i % 10)
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + P",
    hl.dsp.exec_cmd('grim -g "$(slurp -o)" ' .. os.getenv("HOME") .. '/Pictures/screenshots/$(date +\'%s_grim.png\')'))
hl.bind(mainMod .. " + SHIFT + P",
    hl.dsp.exec_cmd('grim -g "$(slurp -o)" - | wl-copy'))


-- hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("systemctl suspend"), { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({ match = { class = "firefox" },       workspace = "2" })
hl.window_rule({ match = { class = "google-chrome" }, workspace = "2" })
hl.window_rule({ match = { class = "zen" },           workspace = "2" })
hl.window_rule({ match = { class = "Opera GX" },           workspace = "2" })
hl.window_rule({ match = { class = "discord" },       workspace = "3" })
hl.window_rule({ match = { class = "YouTube Music" }, workspace = "5" })

hl.window_rule({ match = { class = "google-chrome", title = "Open File" }, float = true })

-- -- ─────────────────────────────────────────────
-- -- CLEAN GODOT WINDOW RULES
-- -- ─────────────────────────────────────────────

-- -- 1. Force the Main Editor Window to TILE
-- -- Godot's main window always contains "Godot Engine" in its title
-- hl.window_rule({
--     match = { 
--         class = ".*godot.*", 
--         title = ".*Godot Engine.*" 
--     },
--     tile = true
-- })

-- -- 2. Float Godot's sub-windows (Project Settings, Editor Popups, Color Pickers)
-- hl.window_rule({
--     match = { 
--         class = "^org\\.godotengine\\.Editor$", 
--         title = "negative:.*Godot Engine.*" 
--     },
--     float = true
-- })

-- 3. Float running game windows launched from editor
hl.window_rule({
    match = { 
        title = "^Godot$", 
        class = "negative:^org\\.godotengine\\.Editor$" 
    },
    float = true
})

hl.window_rule({ match = { class = "xwaylandvideobridge" }, opacity  = "0.0 override" })
hl.window_rule({ match = { class = "xwaylandvideobridge" }, no_anim  = true })
hl.window_rule({ match = { class = "xwaylandvideobridge" }, no_focus = true })
hl.window_rule({ match = { class = "xwaylandvideobridge" }, max_size = { 1, 1 } })
hl.window_rule({ match = { class = "xwaylandvideobridge" }, no_blur  = true })

-- Sanity check: shows a notification when the FULL config has loaded successfully.
-- Remove this line once everything works.
hl.notification.create({ text = "hyprland.lua loaded OK", timeout = 3000, icon = "ok" })
