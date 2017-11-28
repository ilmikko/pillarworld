require('./ui.rb');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

$ui.show(
	UIAlign.new.append(
		UIBorder.new(width:22,height:12).append(
			UIFlex.new.append(
				UIFlex.new(direction: :col).append(
					UIBorder.new,
					UIBorder.new,
				),
				UIFlex.new(direction: :col).append(
					UIBorder.new,
					UIBorder.new,
				)
			)
			#UIAlign.new.append(
			#	UIText.new('21x11')
			#)
		)
	)
);

sleep
