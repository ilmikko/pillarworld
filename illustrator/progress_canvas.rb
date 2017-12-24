#
# Illustrate how UI::Canvas differs from UI::View. We fill a Canvas with an X every 0.1 seconds, from left to right, top to bottom.
# When we resize, the position doesn't change!
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

	$console.log('aabbcc');
	view.put(0,0,'1');
	view.put(w,0,'2');
	view.put(0,h,'3');
	view.put(w,h,'4');
};

sleep;
