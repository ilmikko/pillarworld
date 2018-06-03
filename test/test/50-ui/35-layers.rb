# 
# Multiple layers
#

UI.new.show(
	UI::Layer.new.append(
		UI::Align.new(horizontalalign: :left, verticalalign: :top).append(
			UI::Text.new("This is a text in the top left corner.")
		),
		UI::Align.new(horizontalalign: :right, verticalalign: :bottom).append(
			UI::Text.new("This is a text in the bottom right corner.")
		),
		UI::Align.new.append(
			UI::Text.new("This is a text.")
		),
	)
);
