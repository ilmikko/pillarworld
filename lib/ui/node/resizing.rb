class UI::Node
	# Min-max control
	attr_reader :width_min, :height_min, :width_max, :height_max;

	def width_min=(v)
		raise "width_min cannot be larger than width_max! (#{v}>#{@width_max})" if !@width_max.nil? and v>@width_max;
		@width_min=v;
	end
	
	def height_min=(v)
		raise "height_min cannot be larger than height_max! (#{v}>#{@height_max})" if !@height_max.nil? and v>@height_max;
		@height_min=v;
	end


	def width_max=(v)
		raise "width_max cannot be smaller than width_min! (#{v}<#{@width_min})" if !@width_min.nil? and v<@width_min;
		@width_max=v;
	end

	def height_max=(v)
		raise "height_max cannot be smaller than height_min! (#{v}<#{@height_min})" if !@height_min.nil? and v<@height_min;
		@height_max=v;
	end

	
	# Content size control
	attr_reader :content_width, :content_height;

	def content_size
		[content_width,content_height];
	end


	def width=(v)
		@width_min=@width_max=v;
		self.change_w=v;
	end

	def height=(v)
		@height_min=@height_max=v;
		self.change_h=v;
	end

	attr_reader :wh;

	# REALIZED width and heights
	def width;
		@wh[0];
	end

	def height;
		@wh[1];
	end

	alias w width
	alias h height

	def resize(w,h)
		width=w;
		height=h;
	end
end
