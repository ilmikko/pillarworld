$LOAD_PATH.push('../lib');

require 'ui';
require 'console';
require 'input';

$LOAD_PATH.push('lib');

require 'illustration';
require 'cursor';

test=Illustration.load('demo/test.ifl');

# Set view w and h
UI.debug=true;

UI.new.show(
	UI::Align.new.append(
		UI::Border.new(width: test.width+2, height: test.height+2).append(
			view=UI::View.new
		)
	)
);

cursor=Cursor.new(test.width,test.height);

view.scene=->{
	# TODO: proper support for getting COLORS from the terminal screen
	# And instead of using FORCE, we just need to check a bit more than just
	# the character (if our colors aren't matching, we still want to write)
	test.each_cell{|x,y,col,char|
		$console.log("#{x},#{y},#{char}");
		view.color(col);
		view.put(x,y,char,force:true);
	}
	view.color("\e[m\e[7m");
	view.put(*cursor.xy,"#{view.get(*cursor.xy)}",force:true);
	view.color("\e[m");
};

$input.listen({
	'j':->{
		
	},
	'k':->{
		
	},
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

sleep;
