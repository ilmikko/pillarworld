#TODO: Instead of resize_wh and xy set all to change_wh and change_xy and change_xywh

class UI::Node
	#########
	protected
	#########
	
	def change_x=(v)
		@xy[0]=v;
	end

	def change_y=(v)
		@xy[1]=v;
	end

	def change_xy=(xy)
		self.change_x=xy[0];
		self.change_y=xy[1];
	end

	def clamp(v,min,max)
		if !min.nil? or !max.nil?
			if !max.nil? and v>max
				v=max;
			elsif !min.nil? and v<min
				v=min;
			end
		end

		return v;
	end

	def change_w=(v)
		min = @width_min;
		max = @width_max;

		@wh[0]=clamp(v,min,max);
	end

	def change_h=(v)
		min = @height_min;
		max = @height_max;

		@wh[1]=clamp(v,min,max);
	end

	def change_wh=(wh)
		# SET parent has resized!
		self.change_w=wh[0];
		self.change_h=wh[1];
	end
end
