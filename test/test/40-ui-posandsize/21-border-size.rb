#
# Border size test - in cases where width/height is a floating point number
#

UI.new.show(
	UI::Split.new(direction: :row).append(
		UI::Stack.new.append(
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow:0, width: 10).append(
					UI::Text.new("10x1")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow:0, width: 11).append(
					UI::Text.new("11x1")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow: 0, width: 11.3).append(
					UI::Text.new("11.3x1")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow: 0, width: 11.4999).append(
					UI::Text.new("11.4999x1")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow: 0, width: 11.5).append(
					UI::Text.new("11.5x1")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Border.new(grow: 0, width: 11.7).append(
					UI::Text.new("11.7x1")
				)
			),
		),
		UI::Split.new(direction: :row).append(
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:10).append(
					UI::Text.new("0x10")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:11).append(
					UI::Text.new("0x11")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:11.3).append(
					UI::Text.new("0x11.3")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:11.4999).append(
					UI::Text.new("0x11.4999")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:11.5).append(
					UI::Text.new("0x11.5")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Border.new(grow: 0, height:11.7).append(
					UI::Text.new("0x11.7")
				)
			)
		)
	)
);
