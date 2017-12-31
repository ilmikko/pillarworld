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
	test.each_cell{|x,y,col,char|
		$console.log("#{x},#{y},#{char},#{col}");
		view.put(x,y,char,color:col);
	}

	cursorpos=cursor.xy;
	view.put(*cursorpos,test.get_char(*cursorpos),color:test.get_col(*cursorpos),negate:true);
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
