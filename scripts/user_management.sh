#!/bin/bash
# User Management Script

ACTION=$1
USERNAME=$2
PASSWORD=$3
ROLE=$4

if [ -z "$ACTION" ] || [ -z "$USERNAME" ]; then
    echo "Usage: $0 {create|delete|lock|unlock} <username> [password] [role]"
    exit 1
fi

case "$ACTION" in
    create)
        if id "$USERNAME" &>/dev/null; then
            echo "User $USERNAME already exists."
        else
            useradd -m -s /bin/bash "$USERNAME"
            if [ -n "$PASSWORD" ]; then
                echo "$USERNAME:$PASSWORD" | chpasswd
            fi
            if [ "$ROLE" == "admin" ]; then
                usermod -aG sudo "$USERNAME"
            fi
            echo "User $USERNAME created."
        fi
        ;;
    delete)
        if id "$USERNAME" &>/dev/null; then
            userdel -r "$USERNAME"
            echo "User $USERNAME deleted."
        else
            echo "User $USERNAME does not exist."
        fi
        ;;
    lock)
        passwd -l "$USERNAME"
        echo "User $USERNAME locked."
        ;;
    unlock)
        passwd -u "$USERNAME"
        echo "User $USERNAME unlocked."
        ;;
    *)
        echo "Invalid action. Use create, delete, lock, or unlock."
        exit 1
        ;;
esac
