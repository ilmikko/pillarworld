$input.listen({
	' ':->{
		# ERASE
		illustration.set_char(*cursor.xy,' ');
		view.redraw;
	},
	'y':->{
		cursor.copy=[illustration.get_char(*cursor.xy),illustration.get_col(*cursor.xy)];
	},
	'p':->{
		char,col=cursor.copy;
		illustration.set_char(*cursor.xy,char);
		illustration.set_col(*cursor.xy,col);
		view.redraw;
	}
});
