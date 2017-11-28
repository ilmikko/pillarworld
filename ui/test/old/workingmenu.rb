require('./ui.rb');

# TODO: Make the paragraphs go bold to indicate selection status

$ui.show(
	UIPadding.new(padding:4).append(
		UIBorder.new.append(
			UITextArea.new().append(
				UIParagraph.new.append('Paragraph 1'),
				UIParagraph.new.append('Paragraph 2 (longer)'),
				UIParagraph.new.append('Shortp 3'),
				UIParagraph.new.append('Paragraph 4')
			)
		)
	)
);

sleep;
