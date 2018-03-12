#
# Check node sizes
#
# We want the node on the top resize correctly in all of the following cases:
#
# 1. Border is taking a fixed height of the stack. (this experiment)
# 2. Border is taking a minimum height of the stack. (WRAP height)
# 3. Border is taking a maximum height of the stack. (GROW height)
#

UI.new.show(
	UI::Stack.new(direction: :col).append(
		UI::Border.new(height: 11).append(
			UI::Align.new.append(
				UI::Text.new('Border with fixed height and growing width')
			)
		),
		UI::Text.new('Text node 1'),
		UI::Text.new('Text node 2'),
		UI::Text.new('Text node 3'),
		UI::Text.new('Text node 4'),
		UI::Text.new('Text node 5')
	)
);
