class Cursor
	attr_accessor :xy,:copy
	def moveX(d)
		@xy[0]+=d;
		@xy[0]=@xy[0].clamp(0,@wh[0]-1);
	end
	def moveY(d)
		@xy[1]+=d;
		@xy[1]=@xy[1].clamp(0,@wh[1]-1);
	end
	def initialize(w,h)
		@xy=[0,0];
		@wh=[w,h];
		@copy=[];
	end
end
