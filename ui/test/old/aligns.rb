require('./ui.rb')

$ui.show(
	UIFlex.new.append(
		UIFlex.new(direction: :col).append(
			UITextArea.new().append(
				UIParagraph.new('Par. 12',textalign: :right)
			),
			UITextArea.new().append(
				UIParagraph.new('Par. 11')
			),
			UITextArea.new().append(
				UIParagraph.new('Par. 10')
			)
		),
		UIFlex.new(direction: :col).append(
			UITextArea.new().append(
				UIParagraph.new('Par. 3',textalign: :right)
			),
			UITextArea.new(verticalalign: :center).append(
				UIParagraph.new('* Why do some communities contain more species than others?  * Are there patterns or gradients of species richness?  * What are the reasons for such patterns?  * Does species richness matter? . 1 lorem ipsum 123451234512345123451234512345123451234512345123451234512345 dolor sit amet a abc abcdef qertyyy vmmco pemoapm sisucio iemak i omivoai jskiei oiaopoe mkkelsi jsioehria poslllem ionvimios moeiiene plloair',textalign: :center)
			),
			UITextArea.new(verticalalign: :center).append(
				UIParagraph.new('Line numero uno!',textalign: :center),
				UIParagraph.new('Another line that is slightly longer',textalign: :center)
			)
		),
		UIFlex.new(direction: :col).append(
			UITextArea.new().append(
				UIParagraph.new('Par. 4')
			),
			UITextArea.new().append(
				UIParagraph.new('Par. 5')
			),
			UITextArea.new().append(
				UIParagraph.new('Par. 6')
			)
		)
	)
);

sleep;
