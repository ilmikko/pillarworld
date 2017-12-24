require('./ui.rb');

$ui.show(
	UIStack.new(verticalalign: :center,horizontalalign: :center).append(
		UIBorder.new(width:10, height:10),
		UIBorder.new(width:5, height:5),
		UIBorder.new(width:4, height:4),
		UIBorder.new(width:20, height:20),
		UIBorder.new(width:4, height:4),
		UIBorder.new(width:5, height:5)
	)
);

sleep;
