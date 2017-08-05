#!/bin/bash

# Gets the screen id of the current session


# First get the current pid
PID=$$

# If we're using tmux then we're in the process tree of the daemon, which
# isn't helpful. 
# We therefore ask tmux for the pid of the client instead.
if [ -n "$TMUX" ]; then
	PID=$(tmux display-message -p "#{client_pid}")
fi

# We then recursively walk upwards until we've found the process that is
# associated with a window
while true; do
	# Just try to get the window information
	WINDOW=$(xdotool search --pid $PID)
	if [ $? -eq 0 ]; then
		# Zero exit code, so success
		break;
	fi
	# Gets the parent id
	PID=$(ps -o ppid= -p $PID)
	# If it's zero, then we didn't find a window
	if [ $PID -eq 0 ]; then
		break;
	fi
done

if [ -n $WINDOW ]; then
	echo $WINDOW
	exit 0
else
	exit 1
fi

