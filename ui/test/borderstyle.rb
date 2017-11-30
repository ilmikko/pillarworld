require('./ui.rb');

$ui.show(
	UIPadding.new(padding:3).append(
		# Default border
		UIBorder.new().append(
			# Discount border with -|+
			UIBorder.new(corner: '+', vertical: '|', horizontal: '-').append(
				# Border with only corners
				UIBorder.new(line: '').append(
					# A strange border
					UIBorder.new(vertical: 'I', ee:'').append(
						# A border with custom doubles
						UIBorder.new(dh: '=', dv: 'H').append(
							# A border with a custom dot and no corners
							UIBorder.new(corner: '', dot: '+')
						)
					)
				)
			)
		)
	)
);

sleep
