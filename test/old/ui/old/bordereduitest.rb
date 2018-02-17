require('./ui.rb');

$ui.show(
	UIBorder.new.append(
		UIFlex.new.append(
			UIFlex.new(direction: :column).append(
				UIBorder.new(characters:'-|┌┐└┘').append(
				       UIParagraph.new("Test",textalign: :right)
				),
				UIBorder.new(color: :red).append(
					UIText.new('Layouts et cetera')
				)
			),
			UIBorder.new(characters: '').append(
				UITextArea.new(verticalalign: :center).append(
					UIParagraph.new("Another Test",textalign: :center)
				)
			)
		)
	)
);

#1		→ a=b=c=d=e=f=g=h=1
#12 		→ a=b=c=d=1; e=f=g=h=2;
#123		→ ab=1; cd=2; e=f=g=h=3;
#1234		→ ab=1; cd=2; ef=3; gh=4; (?)
#12345		→ a=1; b=2; c=3; d=4; e=f=g=h=5;
#123456		→ ab=1; cd=2; e=3; f=4; g=5; h=6;
#1234567		→ a=1; b=2; c=3; d=4; e=5; f=6; gh=7; (?)
#12345678	→ a=1; b=2; c=3; d=4; e=5; f=6; g=7; h=8;

#$ui.show(
#	UITextArea.new(verticalalign: :center).append(
#		UIParagraph.new(
#			UIText.new('Test',color: "\e[033m"),
#			textalign: :center
#		)
#	)
#);

sleep
