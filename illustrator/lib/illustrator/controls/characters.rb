$input.listen({
	'c':->{
		# CHARACTER set
		STDIN.cooked!;
		print("\e[2;H\e[mCHARACTER: [0-65535]");
		ord=STDIN.gets.to_i;
		print("\e[2;H\e[K");
		STDIN.raw!;

		ord=ord.chr('utf-8');
		illustration.set_char(*cursor.xy,ord);
		view.redraw;
	}
});
