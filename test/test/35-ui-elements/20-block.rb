#
# A simple test for the UI::Block element
#

UI.new.show(
	UI::Stack.new(direction: :row).append(
		UI::Block.new(width: 20),UI::Text.new("a"),
		UI::Block.new(width: 3),UI::Text.new("b"),
		UI::Block.new(),UI::Text.new("c"),
	)
);
