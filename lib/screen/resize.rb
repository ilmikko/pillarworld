print("\e[?25l"); # Hide cursor

# New thread for resizing check
Thread.new{
	lastwinsize=nil;
	loop{
		# Resize check, every n frames
		if ($stdin.winsize!=lastwinsize)
			lastwinsize=$stdin.winsize;
			Screen.resize(lastwinsize.reverse);
		end

		# Everyone needs some rest
		sleep(1.0/60.0);
	}
}

at_exit{
	print("\e[?25h\e[H\e[m"); # Clear screen, Show cursor, Reset color
}
