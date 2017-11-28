class UINode
	# position: [x,y] in pixels
	def xy;[self.x,self.y];end
	def x;@xy[0];end
	def y;@xy[1];end

	def x=(v);
		@xy[0]=v;
	end
	def y=(v);
		@xy[1]=v;
	end

	def xy=(xy);
		self.x=xy[0];
		self.y=xy[1];
	end

	# size: [w,h] in pixels
	def w;@wh[0];end
	def h;@wh[1];end

	def w=(v);
		# Use the preferred width if we have the space
		@wh[0]=(!@preferredwh[0].nil? && v>@preferredwh[0]) ? @preferredwh[0] : v;
	end
	def h=(v);
		# Use the preferred height if we have the space
		@wh[1]=(!@preferredwh[1].nil? && v>@preferredwh[1]) ? @preferredwh[1] : v;
	end

	# Shortcuts
	def wh;[self.w,self.h];end
	def wh=(wh);
		self.w=wh[0];
		self.h=wh[1];
	end

	def xywh=(xywh);
		self.xy=xywh[0..1];
		self.wh=xywh[2..3];
	end
end
