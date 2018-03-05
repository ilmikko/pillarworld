# 
# Simple text with border test, changing content should change the border size as well
#

# FIXME: How do we differentiate between a fullscreen border and a text wrapping border?
UI.new.show(
	UI::Flex.new.append(
		UI::Wrap.new.append(
			UI::Wrap.new.append(
				UI::Text.new("This text should be bordered")
			)
		),
		UI::Border.new.append(
			UI::Text.new("This text is inside a border")
		)
	)
);
