# 
# UIParagraph
# Contains a paragraph of text, without newlines. The children are treated as words.
# The words wrap if there is not enough space.
#
# Usage:
# UIParagraph.new(textalign: :center).append(UIText.new('Text'))
#
class UIParagraph < UIStack
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

	def change
		super;

		# Resize to the height of our kids
		height=0;

		@children.each{|c|
			height+=c.h;
		}

		@wh[1]=height;
	end

	def append(*items)
		super(*items.map{|item|
			# We allow strings.
			if !item.is_a? UINode
				if item.is_a? String
					# Split strings by newline, and make them UITextLines
					item.split(/\n/).map{|i|
						i=UITextLine.new(i);
					};
				else
					raise "Error: Cannot append #{item.class} into #{self.class}";
				end
			else
				item;
			end
		}.flatten);
	end

	def initialize(*items,textalign: :left,**_)
		super(**_);

		append(*items);
	end
end
