# 
# UIStack
# An opposer to UIFlex - where Flex tries to use all the space as it can, Stack tries to stack as many child elements next to each other as it can.
#

class UIStack < UIArray
	def change
		w,h=@wh;
		x,y=@xy;
		
		len=@children.length;
		offset=0;

		if @direction==:row
			for i in 0...len
				c=@children[i];
				c.xywh=[x+offset,y,w-offset,h];
				c.change;
				offset+=c.w;
			end
		else
			for i in 0...len
				c=@children[i];
				c.xy=[x,y+offset];
				c.xywh=[x,y+offset,w,h-offset];
				c.change;
				offset+=c.h;
			end
		end
	end

	def initialize(direction: :row,**_)
		super(**_);
		@direction=direction;
	end
end
