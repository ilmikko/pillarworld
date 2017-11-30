require('./ui.rb');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

$ui.show(
	UIPadding.new(padding:8).append(
		UIBorder.new().append(
			UIText.new('Test')
		)
	)
);

sleep
