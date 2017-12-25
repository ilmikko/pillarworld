$LOAD_PATH.push('../lib');

$LOAD_PATH.push('lib');

require 'ui';
require 'console';

require 'illustration';

test=Illustration.load('demo/test.ifl');

# Set view w and h

UI.new.show(
	UI::Align.new.append(
		UI::Border.new(width: test.width+2, height: test.height+2).append(
			view=UI::View.new
		)
	)
);

view.scene=->{
	test.each_cell{|x,y,cell|
		$console.log("#{x},#{y},#{cell}");
		view.put(x,y,cell);
	}
};

sleep;
