#
# Node size test when there is a 2:1 split between the growing elements.
#

UI.new.show(
	UI::Stack.new(direction: :col).append(
		UI::Border.new(grow: 2).append(
			UI::Align.new.append(
				UI::Text.new('Border with growing height and growing width (2:1)')
			)
		),
		UI::Border.new(grow: 1).append(
			UI::Align.new.append(
				UI::Text.new('Another border with the same properties (1:2)')
			)
		),
		UI::Text.new('Text node 1'),
		UI::Text.new('Text node 2'),
		UI::Text.new('Text node 3'),
		UI::Text.new('Text node 4'),
		UI::Text.new('Text node 5')
	)
);
