#
# Stacked text border elements
#

UI.new.show(
	UI::Align.new.append(
		UI::Stack.new(direction: :row).append(
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text 2')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text 3')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text 4')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text')
			),
			UI::Border.new(grow:0).append(
				UI::Text.new('This is a text')
			)
		)
	)
);
