$LOAD_PATH.push('../lib');

require 'ui';
require 'console';
require 'input';

$LOAD_PATH.push('lib');

require 'illustration';
require 'cursor';

illustration=Illustration.load('demo/test.ifl');

# Set view w and h
UI.debug=true;

# FIXME: Why are the stack contents aligned to the center...?
UI.new.show(
	UI::Align.new.append(
		UI::Stack.new(width:50, height:30, direction: :col).append(
			UI::Border.new(width: illustration.width+2, height: illustration.height+2).append(
				view=UI::View.new
			),
			text=UI::Text.new('99999@255,255,255')
		)
	)
);

cursor=Cursor.new(illustration.width,illustration.height);

view.scene=->{

	cursorpos=cursor.xy;

	# FIXME: Text is being reverse videoed because of the last view.put...
	text.text="#{illustration.get_char(*cursorpos).ord}@#{illustration.get_col(*cursorpos).rgb.join(',')}                    ";
	text.redraw;

	illustration.each_cell{|x,y,col,char|
		$console.log("#{x},#{y},#{char},#{col}");
		view.put(x,y,char,color:col);
	}

	view.put(*cursorpos,illustration.get_char(*cursorpos),color:illustration.get_col(*cursorpos),negate:true);

};


$input.listen({
	'1':->{
		# ASCII down
		o=illustration.get_char(*cursor.xy);
		o=o.ord-1;
		o=0 if o<0;
		o=o.chr('utf-8');
		illustration.set_char(*cursor.xy,o);
		view.redraw;
	},
	'2':->{
		# ASCII up
		o=illustration.get_char(*cursor.xy);
		o=(o.ord+1).chr('utf-8');
		illustration.set_char(*cursor.xy,o);
		view.redraw;
	},
	'4':->{
		# test
		col=illustration.get_col(*cursor.xy);
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
