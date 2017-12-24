require_relative('../ui');

UI.new.show(
	UI::Padding.new(padding: 8).append(
		UI::Border.new().append(
			UI::Paragraph.new("One little line\nTwo little lines\nThe third one is a wee bit bigger than the others",textalign: :right)
		)
	)
);

sleep
