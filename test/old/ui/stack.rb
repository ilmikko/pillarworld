require_relative('../ui');

UI.new.show(
	UI::Stack.new(verticalalign: :center,horizontalalign: :center).append(
		UI::Border.new(width:10, height:10),
		UI::Border.new(width:5, height:5),
		UI::Border.new(width:4, height:4),
		UI::Border.new(width:20, height:20),
		UI::Border.new(width:4, height:4),
		UI::Border.new(width:5, height:5)
	)
);

sleep;
