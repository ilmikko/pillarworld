require_relative('../ui');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

UI.new.show(
	UI::Padding.new(padding:11).append(
		UI::Flex.new(direction: :column).append(
			UI::Flex.new.append(
				UI::Border.new().append(
					UI::Text.new('1')
				),
				UI::Border.new().append(
					UI::Text.new('2')
				),
				UI::Border.new().append(
					UI::Text.new('3')
				)
			),
			UI::Flex.new.append(
				UI::Border.new().append(
					UI::Text.new('4')
				),
				UI::Border.new().append(
					UI::Text.new('5')
				),
				UI::Border.new().append(
					UI::Text.new('6')
				)
			),
			UI::Flex.new.append(
				UI::Border.new().append(
					UI::Text.new('7')
				),
				UI::Border.new().append(
					UI::Text.new('8')
				),
				UI::Border.new().append(
					UI::Text.new('9')
				)
			)
		)
	)
);

sleep
