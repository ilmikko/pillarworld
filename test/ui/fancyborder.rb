require_relative('../ui');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

UI.new.show(
	UI::Align.new.append(
		UI::Border.new(width:22,height:12).append(
			UI::Flex.new.append(
				UI::Flex.new(direction: :col).append(
					UI::Border.new,
					UI::Border.new,
				),
				UI::Flex.new(direction: :col).append(
					UI::Border.new,
					UI::Border.new,
				)
			)
			#UIAlign.new.append(
			#	UIText.new('21x11')
			#)
		)
	)
);

sleep
