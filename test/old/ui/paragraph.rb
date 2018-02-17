require_relative('../ui');

UI.new.show(
	UI::Padding.new(padding: 8).append(
		UI::Border.new().append(
			UI::Stack.new.append(
				UI::Paragraph.new("One little line\nTwo little lines\nThe third one is a wee bit bigger than the others",textalign: :right),
				UI::Paragraph.new("This is another paragraph.\nIt has multiple lines as well.")
			)
		)
	)
);

sleep
