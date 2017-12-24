$LOAD_PATH.push('../lib');

require 'ui';
require 'console';

$console.loglevel=-1000;

$console.debug('Debug messages work');

UI.debug=true;

UI.new.show(
	UI::Border.new(padding: 6).append(
		UI::Border.new(w: :h).append(
			view=UI::View.new
		)
	)
);

view.write(2,2,'This is a test');

sleep;
