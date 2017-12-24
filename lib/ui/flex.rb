# 
# UIFlex
# 'Flexes' the children to use most of the available space they possibly can.
# For example, if there are two children, they both use 50% of the space.
# The splitting axis can be determined on initialization.
#
# Usage:
# UIFlex.new(direction: :col).append(...)
#
class UI::Flex < UI::Array
	def append(*items)
		super(*items);
		self;
	end

	def change
		len=@children.length.to_f;

		w,h=@wh;
		x,y=@xy;

		# Don't need to reflow
		# If you don't have any children
		if len>0
			if @direction==:row
				part=w/len;

				for i in 0...len
					c=@children[i];
					c.xywh=[x+part*i,y,part,h];
					c.change;
				end
			else
				part=h/len;

				for i in 0...len
					c=@children[i];
					c.xywh=[x,y+part*i,w,part];
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
