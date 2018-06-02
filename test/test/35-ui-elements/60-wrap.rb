#
# UI::Wrap test
#

UI.new.show(
	UI::Wrap.new.append(
		*"This is a simple text wrap thingy which should work. Let's see if it works with a longer string that should wrap in any case, regardless of the screen size that is used. Unless your screen size is huge, of course, which in itself is very likely to happen at some point as screen sizes have been getting bigger and bigger by the day. My friend has one of these 4K screens and it's almost too large to look at. I mean how on earth are you supposed to get any work done, as all the UI elements take ages to find with your mouse? Everything is as spaced out as space and time itself and it makes me a bit anxious. No thanks, I'm perfectly fine with my Full HD screen for now.".split(/( )/).map{|s| UI::Text.new s}
	)
);
