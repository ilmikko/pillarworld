$input.listen({
	'1':->{
		# RED set
		col=illustration.get_col(*cursor.xy);

		# Read a string from the user (0-255)
		# TODO: Make this a UI event when the UI is ready for it
		print("\e[2;H\e[mRED [0-255]:");
		STDIN.cooked!;
		color=STDIN.gets();
		color=color.to_i;
		print("\e[2;H\e[K");
		STDIN.raw!;

		col.r=(color).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'2':->{
		# GREEN set
		col=illustration.get_col(*cursor.xy);

		# Read a string from the user (0-255)
		# TODO: Make this a UI event when the UI is ready for it
		print("\e[2;H\e[mGREEN [0-255]:");
		STDIN.cooked!;
		color=STDIN.gets();
		color=color.to_i;
		print("\e[2;H\e[K");
		STDIN.raw!;

		col.g=(color).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'3':->{
		# BLUE set
		col=illustration.get_col(*cursor.xy);

		# Read a string from the user (0-255)
		# TODO: Make this a UI event when the UI is ready for it
		print("\e[2;H\e[mBLUE [0-255]:");
		STDIN.cooked!;
		color=STDIN.gets();
		color=color.to_i;
		print("\e[2;H\e[K");
		STDIN.raw!;

		col.b=(color).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'5':->{
		# RED down
		col=illustration.get_col(*cursor.xy);
		col.r=(col.r-1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'6':->{
		# RED up
		col=illustration.get_col(*cursor.xy);
		col.r=(col.r+1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'7':->{
		# GREEN down
		col=illustration.get_col(*cursor.xy);
		col.g=(col.g-1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'8':->{
		# GREEN up
		col=illustration.get_col(*cursor.xy);
		col.g=(col.g+1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'9':->{
		# BLUE down
		col=illustration.get_col(*cursor.xy);
		col.b=(col.b-1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	},
	'0':->{
		# BLUE up
		col=illustration.get_col(*cursor.xy);
		col.b=(col.b+1).clamp(0,255);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	}
});
