# 
# UIParagraph
# Contains a paragraph of text, without newlines. The children are treated as words.
# The words wrap if there is not enough space.
#
# Usage:
# UIParagraph.new(textalign: :center).append(UIText.new('Text'))
#
class UIParagraph < UIArray
	@@textaligns={
		left:0,
		center:0.5,
		right:1
	};
	def textalign;
		@@textaligns.key(@textalign);
	end
	def textalign=(v);
		@textalign=@@textaligns[v];
	end

	def initialize(textalign: :left,**_)
		@wh=[10,10];
		@preferredwh=[10,10];
		super(**_);
	end
end
