$input.listen({
	's':->{
		# Save
		STDIN.cooked!;
		print("\e[2;H\e[mSAVE FILE: ");
		filename=STDIN.gets.strip;
		print("\e[2;H\e[K");
		STDIN.raw!;

		$console.log("Saving to demo/#{filename}.ifl");
		Illustration.save(illustration,"demo/#{filename}.ifl");
	},
	'l':->{
		# Load
		STDIN.cooked!;
		print("\e[2;H\e[mLOAD FILE: ");
		filename=STDIN.gets.strip;
		print("\e[2;H\e[K");
		STDIN.raw!;
	}
});
