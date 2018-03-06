# TODO: How to make border act like a wrap?

UI.new.show(
	UI::Border.new().append(
		UI::Stack.new(direction: :row).append(
			UI::Wrap.new.append(
				UI::Text.new("Hello")
			),
			UI::Wrap.new.append(
				UI::Text.new("World")
			)
		)
	)
);
