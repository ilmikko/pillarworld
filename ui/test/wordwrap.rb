require('./ui.rb');

$ui.show(
	UIPadding.new(padding: 8).append(
		UIBorder.new().append(
		       UITextLine.new("This is a single line of text.")
			#UIParagraph.new("This is a text.\nThis should be on a new line.")
			#gets translated to
			#UITextLine.new("This is a text."),UITextLine.new("This should be on a new line.")
			#gets translated to
			#UIText.new("This"),UIText.new("is"),...
		)
	)
);

sleep
