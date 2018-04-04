# 
# UISplit
# Splits the children to use most of the available space they possibly can.
# For example, if there are two children, they both use 50% of the space.
# The splitting axis can be determined on initialization.
#
# Usage:
# UISplit.new(direction: :col).append(...)
#
class UI::Split < UI::Array
	def change
		len=@children.length.to_f;

		w,h=@wh;
		x,y=@xy;

		# Don't need to reflow
		# If you don't have any children
		# *taps temple*
		if len>0
			if @direction==:row
				part=w.to_f/len;

				for i in 0...len
					c=@children[i];
					c.change_xy=[x+part*i,y];
					c.change_wh=[part,h];
					c.change;
				end
			else
				part=h.to_f/len;

				for i in 0...len
					c=@children[i];
					c.change_xy=[x,y+part*i];
					c.change_wh=[w,part];
					c.change;
				end
			end
		end
	end

	def initialize(direction: :row,**_)
		super(**_);
		@direction=direction;
	end
end
