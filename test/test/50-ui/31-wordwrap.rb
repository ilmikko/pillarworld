#
# Text line wrapping test
#

UI.new.show(
	UI::Padding.new(padding: 8).append(
		UI::Border.new().append(
			UI::Wrap.new().append(
				*"Hello, this is a text line wrapping test. The text should be long enough to be wrapping to multiple lines including screens that are of decent size and also console screens where it's usual. I have no idea what I'm writing here but it does it's job.".split(/( )/).map{|s|UI::Text.new(s)}
			)
		)
	)
);
