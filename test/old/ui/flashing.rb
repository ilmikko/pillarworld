require_relative('../ui');

require('screen');
Screen.new;

UI.new.show(
	UI::Border.new(padding: 6).append(
		UI::Border.new.append(
			#$view=UI::View.new
		)
	)
);

sleep;
