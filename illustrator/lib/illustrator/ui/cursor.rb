class Cursor
	attr_accessor :xy,:copy
	def resize(w,h)
		@wh=[w,h];
	end
	def moveX(d)
		#$console.log("Move cursor by #{d} in [0,#{@wh[0]-1}]");
		@xy[0]+=d;
		@xy[0]=@xy[0].clamp(0,@wh[0]-1);
	end
	def moveY(d)
		@xy[1]+=d;
		@xy[1]=@xy[1].clamp(0,@wh[1]-1);
	end
	def initialize(w=1,h=1)
		@xy=[0,0];
		@wh=[w,h];
		@copy=[];
	end
end
