
#!/bin/bash

# Default interface is 'lo' (localhost), perfect for local Godot testing
INTERFACE="lo"
DELAY=""
JITTER=""
LOSS=""
RATE=""

# Function to clean up the network rules when you press Ctrl+C
cleanup() {
    echo -e "\n[!] Ctrl+C detected. Cleaning up network rules on '$INTERFACE'..."
    # 2>/dev/null hides the error if there were no rules to delete
    tc qdisc del dev "$INTERFACE" root 2>/dev/null
    echo "[✓] Network simulation stopped. Back to normal!"
    exit 0
}

# Trap the SIGINT signal (Ctrl+C) and route it to the cleanup function
trap cleanup SIGINT

# Function to display usage help
usage() {
    echo "Usage: sudo $0 [OPTIONS]"
    echo "Simulate bad network conditions for game testing."
    echo ""
    echo "Options:"
    echo "  -i, --interface <dev>    Network interface (default: lo)"
    echo "  -d, --delay <time>       Latency (e.g., 100ms)"
    echo "  -j, --jitter <time>      Latency variation (e.g., 20ms)"
    echo "  -l, --loss <percent>     Packet loss (e.g., 5%)"
    echo "  -r, --rate <speed>       Bandwidth limit (e.g., 1mbit, 500kbit)"
    echo "  -h, --help               Show this help message"
    echo ""
    echo "Example: sudo $0 -i lo -d 150ms -j 30ms -l 2% -r 2mbit"
    exit 1
}

# Parse command line arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -i|--interface) INTERFACE="$2"; shift ;;
        -d|--delay) DELAY="$2"; shift ;;
        -j|--jitter) JITTER="$2"; shift ;;
        -l|--loss) LOSS="$2"; shift ;;
        -r|--rate) RATE="$2"; shift ;;
        -h|--help) usage ;;
        *) echo "Unknown parameter: $1"; usage ;;
    esac
    shift
done

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
    echo "Error: This script must be run with sudo to modify network rules."
    exit 1
fi

# Build the netem arguments string based on provided parameters
NETEM_ARGS=""
if [ -n "$DELAY" ]; then
    NETEM_ARGS="$NETEM_ARGS delay $DELAY"
    if [ -n "$JITTER" ]; then
        NETEM_ARGS="$NETEM_ARGS $JITTER"
    fi
fi
if [ -n "$LOSS" ]; then
    NETEM_ARGS="$NETEM_ARGS loss $LOSS"
fi
if [ -n "$RATE" ]; then
    NETEM_ARGS="$NETEM_ARGS rate $RATE"
fi

# Prevent running without any parameters
if [ -z "$NETEM_ARGS" ]; then
    echo "Error: No network conditions specified."
    usage
fi

# 1. Clear any existing rules just in case it crashed previously
tc qdisc del dev "$INTERFACE" root 2>/dev/null

# 2. Apply the new rules
echo "[*] Applying network conditions on '$INTERFACE' ->$NETEM_ARGS"
tc qdisc add dev "$INTERFACE" root netem $NETEM_ARGS

# 3. Keep the script running to wait for Ctrl+C
if [ $? -eq 0 ]; then
    echo -e "\n[✓] SIMULATION ACTIVE!"
    echo "[!] Keep this window open. Press [Ctrl+C] to stop and revert to normal."
    # Wait infinitely without consuming CPU
    tail -f /dev/null
else
    echo "[x] Failed to apply rules. Check your parameter formatting."
    exit 1
fi
