#
# UI::Stack and element wrap test
#

UI.new.show(
	UI::Stack.new(direction: :col).append(
		UI::Border.new(grow:0).append(
			UI::Border.new(grow:0).append(
				UI::Text.new("This")
			)
		),
		UI::Border.new(grow:0).append(
			UI::Text.new("is")
		),
		UI::Text.new("text")
	)
);
