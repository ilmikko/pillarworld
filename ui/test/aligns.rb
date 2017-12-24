require('./ui.rb');

$ui.show(
	UIPadding.new(padding:2).append(
		UIFlex.new(direction: :column).append(
			UIFlex.new.append(
				UIBorder.new.append(
					UIAlign.new().append(
						UIText.new('Default')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :center,  ha: :center).append(
						UIText.new('Center')
					)
				),
				UIBorder.new.append(
					UIAlign.new(ha: :right).append(
						UIText.new('East')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :bottom).append(
						UIText.new('South')
					)
				)
			),
			UIFlex.new.append(
				UIBorder.new.append(
					UIAlign.new(ha: :left).append(
						UIText.new('West')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :top).append(
						UIText.new('North')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :top, ha: :left).append(
						UIText.new('NW')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :top, ha: :right).append(
						UIText.new('NE')
					)
				)
			),
			UIFlex.new.append(
				UIBorder.new.append(
					UIAlign.new(va: :bottom, ha: :left).append(
						UIText.new('SW')
					)
				),
				UIBorder.new.append(
					UIAlign.new(va: :bottom, ha: :right).append(
						UIText.new('SE')
					)
				),
				UIBorder.new.append(
					UIAlign.new.append(
						UIText.new('Default')
					)
				),
				UIBorder.new.append(
					UIText.new('No align')
				)
			)
		)
	)
);

sleep
