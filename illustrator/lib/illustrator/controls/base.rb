$input.listen({
	"\e[A":->{
		cursor.moveY(-1);
		view.redraw;
	},
	"\e[B":->{
		cursor.moveY(1);
		view.redraw;
	},
	"\e[C":->{
		cursor.moveX(1);
		view.redraw;
	},
	"\e[D":->{
		cursor.moveX(-1);
		view.redraw;
	}
});
