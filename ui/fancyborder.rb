require('./ui.rb');

# time to go modal; how could I say that the max-width and max-height for this are 20 in every case? And of course centered?

$ui.show(
	UIAlign.new.append(
		UIBorder.new(width:21,height:11).append(
			UIAlign.new.append(
				UIText.new('21x11')
			)
			#UITextArea.new(verticalalign: :center).append(
			#	UIParagraph.new("21x11",textalign: :center)
			#)
		)
	)
);

sleep
