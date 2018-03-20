#
# Border positioning test - in cases where position is a floating point number
#

UI.new.show(
	UI::Split.new(direction: :row).append(
		UI::Stack.new.append(
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:0),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x0")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:1),
				UI::Border.new(grow: 0).append(
					UI::Text.new("1x0")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:1.3),
				UI::Border.new(grow: 0).append(
					UI::Text.new("1.3x0")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:1.4999),
				UI::Border.new(grow: 0).append(
					UI::Text.new("1.4999x0")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:1.5),
				UI::Border.new(grow: 0).append(
					UI::Text.new("1.5x0")
				)
			),
			UI::Stack.new(direction: :row, grow:0).append(
				UI::Block.new(width:1.7),
				UI::Border.new(grow: 0).append(
					UI::Text.new("1.7x0")
				)
			)
		),
		UI::Split.new(direction: :row).append(
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:0),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x0")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:1),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x1")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:1.3),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x1.3")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:1.4999),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x1.4999")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:1.5),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x1.5")
				)
			),
			UI::Stack.new(grow:0).append(
				UI::Block.new(height:1.7),
				UI::Border.new(grow: 0).append(
					UI::Text.new("0x1.7")
				)
			)
		)
	)
);
