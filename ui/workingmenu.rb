require('./ui.rb');

# TODO: Make the paragraphs go bold to indicate selection status

$ui.show(
	UIPadding.new(padding:4).append(
		UIBorder.new.append(
			UITextArea.new(verticalalign: :center).append(
				UIParagraph.new('Paragraph 1'),
				UIText.new(''),
				UIParagraph.new('Paragraph 2 (longer)'),
				UIText.new(''),
				UIParagraph.new('Shortp 3'),
				UIText.new(''),
				UIParagraph.new('Paragraph 4')
			)
		)
	)
);

sleep;
