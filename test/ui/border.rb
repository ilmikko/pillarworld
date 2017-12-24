require('./ui.rb');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

$ui.show(
	UIPadding.new(padding:11).append(
		UIFlex.new(direction: :column).append(
			UIFlex.new.append(
				UIBorder.new().append(
					UIText.new('1')
				),
				UIBorder.new().append(
					UIText.new('2')
				),
				UIBorder.new().append(
					UIText.new('3')
				)
			),
			UIFlex.new.append(
				UIBorder.new().append(
					UIText.new('4')
				),
				UIBorder.new().append(
					UIText.new('5')
				),
				UIBorder.new().append(
					UIText.new('6')
				)
			),
			UIFlex.new.append(
				UIBorder.new().append(
					UIText.new('7')
				),
				UIBorder.new().append(
					UIText.new('8')
				),
				UIBorder.new().append(
					UIText.new('9')
				)
			)
		)
	)
);

sleep
