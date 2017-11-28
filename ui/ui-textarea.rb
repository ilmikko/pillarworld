# Obsolete
class UITextArea < UIArray
	@@verticalaligns={
		top:0,
		center:0.5,
		bottom:1
	}

	def verticalalign;
		@@verticalaligns.key(@verticalalign);
	end
	def verticalalign=(v);
		@verticalalign=@@verticalaligns[v];
	end
	def change
		len=@children.length;

		# 1. Calculate how much our paragraphs will be squished on the x axis - word wrap the children, get their heights individually
		# 2. Using the combined height of the child elements, calculate the positions of the children according to our vertical align
		x,y=@xy;
		w,h=@wh;

		ox,oy=[0,0];

		for i in 0...len
			c=@children[i];

			# Remove oy from h to state the available height for the text elements
			c.xywh=[x,y+oy,w,h-oy];
			c.change;

			oy+=c.h;
			#c.y=10;#y+oy;
		end

		# oy is now known, the total height of our children.
		# We can now totally work out the vertical align.
		verticaloffset=(h-oy)*@verticalalign;

		@children.each{|c|
			c.y+=verticaloffset;
			c.change;
		}
	end
	def initialize(verticalalign: :top,**_)
		super(**_);
		self.verticalalign=verticalalign;
	end
end
