$stdout.print("\e[?25l\e[H"); # Hide cursor, reset its position

# New thread for resizing check
Thread.new{
	lastwinsize=nil;
	loop{
		# Resize check, every n frames
		if ($stdin.winsize!=lastwinsize)
			lastwinsize=$stdin.winsize;
			Screen.resize(*lastwinsize.reverse);
		end

		# Everyone needs some rest
		sleep(1.0/60.0);
	}
}

at_exit{
	$stdout.print("\e[?25h\e[m"); # Show cursor, Reset color
}
