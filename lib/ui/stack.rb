# 
# UIStack
# An opposer to UIFlex - where Flex tries to use all the space as it can, Stack tries to stack as many child elements next to each other as it can.
#

class UI::Stack < UI::Align
	def change
		w,h=@wh;
		x,y=@xy;
		
		len=@children.length;
		offset=0;
		align=0;

		# calculate content size
		contentsize=[0,0];
		if @direction==:row
			@children.each{|c|
				c.resize_wh=@wh;
				c.change;
				contentsize[0]+=c.w;
				contentsize[1]=c.h if c.h>contentsize[1];
			}
		else
			@children.each{|c|
				c.resize_wh=@wh;
				c.change;
				contentsize[1]+=c.h;
				contentsize[0]=c.w if c.w>contentsize[0];
			}
		end

		# Calc align offsets
		align=[(w-contentsize[0])*@horizontalalign,(h-contentsize[1])*@verticalalign];

		if @direction==:row
			@children.each{|c|
				c.xy=[x+offset+align[0],y+align[1]];
				c.resize_wh=[w-offset-align[0],h-align[1]];
				c.change;
				offset+=c.w;
			}
		else
			@children.each{|c|
				c.xy=[x+align[0],y+offset+align[1]];
				c.resize_wh=[w-align[0],h-offset-align[1]];
				c.change;
				offset+=c.h;
			}
		end

	end

	def initialize(direction: :col,**_)
		# Default stack align to top left
		super(va: :top, ha: :left, **_);

		@direction=direction;
	end
end
