# 
# Multiple layers
#

# Hack to get a wrapping effect on elements
# TODO: Silly idea, but would this be something that UI::Layer has?
# TODO: i.e. Only when specifically requested the contents would fill to max
# TODO: additionally this could be something of UI::Align, as the problems
# TODO: only arise when using UI::Align
class UI::Hack < UI::Layer
	def change
		@wh=content_size;
		super;
	end
end

UI.new.show(
	UI::Layer.new.append(
		UI::Align.new(horizontalalign: :left, verticalalign: :top).append(
			UI::Text.new("This is a text in the top left corner.")
		),
		UI::Align.new(horizontalalign: :right, verticalalign: :bottom).append(
			UI::Text.new("This is a text in the bottom right corner.")
		),
		UI::Align.new.append(
			UI::Hack.new.append(
				UI::Border.new.append(
					UI::Text.new("This is a text.")
				)
			)
		),
	)
);
