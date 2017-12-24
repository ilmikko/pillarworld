require('./ui.rb');

$ui.show(
	UIPadding.new(padding: 8).append(
		UIBorder.new().append(
			UIParagraph.new("One little line\nTwo little lines\nThe third one is a wee bit bigger than the others",textalign: :right)
		)
	)
);

sleep
