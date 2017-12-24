#
# Challenge: implement world/matrix.rb as a UIView element.
# Try to optimize it as much as possible. We don't have screen redraws anymore, for example.
#

$LOAD_PATH.push('../lib');

require 'ui';
require 'console';

$console.loglevel=-1000;

$console.debug('Debug messages work');

UI.debug=true;

UI.new.show(
	UI::Border.new(padding: 6).append(
		UI::Border.new.append(
			view=UI::View.new
		)
	)
);

view.scene=->{
	w,h=view.wh;
	w-=1;
	h-=1;

	view.put(0,0,'1');
	view.put(w,0,'2');
	view.put(0,h,'3');
	view.put(w,h,'4');
};

sleep;
