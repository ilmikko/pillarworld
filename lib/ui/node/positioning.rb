class UI::Node
	# position: [x,y] in pixels
	def xy;[x,y];end
	def x;@xy[0];end
	def y;@xy[1];end

	def xy=(xy);
		self.x=xy[0];
		self.y=xy[1];
	end
	def x=(v);@xy[0]=v;end
	def y=(v);@xy[1]=v;end

	# Preferred width and height
	def p_wh;[p_w,p_h];end
	def p_w;@preferred_wh[0];end
	def p_h;@preferred_wh[1];end

	def p_wh=(wh);self.p_w=wh[0];self.p_h=wh[1];end
	def p_w=(v);@preferred_wh[0]=v;end
	def p_h=(v);@preferred_wh[1]=v;end

	# size: [w,h] in pixels
	def w;@wh[0];end
	def h;@wh[1];end

	def w=(v);
		# Use the preferred width if we have the space
		pw=@preferred_wh[0];
		$console.log("Set width of #{self} to #{v}");
		if pw.nil?
			@wh[0]=v; # No preferred width
		elsif v>pw
			@wh[0]=pw; # Use preferred width as we have the space
		end
	end
	def h=(v);
		# Use the preferred height if we have the space
		ph=@preferred_wh[1];
		if ph.nil?
			@wh[1]=v; # No preferred height
		elsif v>ph
			@wh[1]=ph; # Use preferred height as we have the space
		end
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
