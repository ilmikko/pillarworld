#
# Node positioning test - in cases where position is an integer
#

UI.new.show(
	UI::Stack.new(direction: :row).append(
		UI::Stack.new.append(
			UI::Text.new("0x0"),
			UI::Text.new("1x0"),
			UI::Text.new("1.3x0"),
			UI::Text.new("1.5x0"),
			UI::Text.new("1.7x0")
		),
		UI::Stack.new.append(
			UI::Text.new("0x1"),
			UI::Text.new("0x1"),
			UI::Text.new("0x1.3"),
			UI::Text.new("0x1.5"),
			UI::Text.new("0x1.7")
		)
	)
);
