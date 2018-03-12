#
# UIPadding
# Pads the content by a value.
#
# Usage:
# UIPadding.new(padding:1).append(...)
# UIPadding.new(padding-x:4).append(...)
# UIPadding.new(padding-left:2,padding-right:4,padding-top:1).append(...)
#
class UI::Padding < UI::Pass
	@@default_padding=1;

	attr_reader :padding;

	# TODO: Make the element update when padding changes
	def padding=(v);
		@padding=v;
	end

	# We modify content width by adding padding
	def content_width
		super+@padding*2;
	end

	def content_height
		super+@padding*2;
	end

	def change;
		w,h=@wh;
		x,y=@xy;

		width=@padding;
		@children.each{ |c|
			c.change_xy=[x+width,y+width];
			c.change_wh=[w-width*2,h-width*2];
			c.change;
		}
	end

	def initialize(padding:@@default_padding,**_)
		super(**_);

		self.padding=padding;
	end
end
