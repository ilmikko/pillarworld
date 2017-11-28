#
# UIPadding
# Pads the content by a value.
#
# Usage:
# UIPadding.new(padding:1).append(...)
# UIPadding.new(padding-x:4).append(...)
# UIPadding.new(padding-left:2,padding-right:4,padding-top:1).append(...)
#
class UIPadding < UIPass
	@@default_padding=1;

	def padding;@padding;end
	def padding=(v);@padding=v;end

	def change;
		w,h=@wh;
		x,y=@xy;

		width=@padding;
		@children.each{ |child|
			child.xywh=[x+width,y+width,w-width*2,h-width*2];
			child.change;
		}
	end

	def initialize(padding:1,**_)
		super(**_);

		self.padding=padding;
	end
end
