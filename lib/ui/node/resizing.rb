class UI::Node
	def min_width=(v)
		# SET user wanted min_width
		@min_wh[0]=v;
	end
	
	def min_height=(v)
		@min_wh[1]=v;
	end


	def max_width=(v)
		@max_wh[0]=v;
	end

	def max_height=(v)
		@max_wh[1]=v;
	end


	def width=(v)
		# OLD preferred_width
		# SET user wanted min_width and max_width
		self.min_width=self.max_width=v;
		# UPDATE everything as our PREFERRED width is now different
		self.resize_w=v;
	end

	def height=(v)
		self.min_height=self.max_height=v;
		# TODO
		self.resize_h=v;
	end

	attr_reader :wh;

	def width;
		# GET REALIZED width
		@wh[0];
	end

	def height;
		@wh[1];
	end

	alias w width
	alias h height

	# TODO: Clean this up a bit - but these are protected so that a user doesn't accidentally call "resize_wh" when they want to resize an element.
	# What should they call instead?

	#########
	protected
	#########

	def resize_w=(v)
		# SET parent resized width to v!
		# CALC our own REALIZED width
		if !@min_wh[0].nil? or !@max_wh[0].nil?
			# TODO: What if max_width < min_width?
			if !@max_wh[0].nil? and v>@max_wh[0]
				v=@max_wh[0];
			elsif !@min_wh[0].nil? and v<@min_wh[0]
				v=@min_wh[0];
			end
		end
		@wh[0]=v;
	end

	def resize_h=(v)
		if !@min_wh[1].nil? or !@max_wh[1].nil?
			# TODO: What if max_width < min_width?
			if !@max_wh[1].nil? and v>@max_wh[1]
				v=@max_wh[1];
			elsif !@min_wh[1].nil? and v<@min_wh[1]
				v=@min_wh[1];
			end
		end
		@wh[1]=v;
	end

	def resize_wh=(wh)
		# SET parent has resized!
		self.resize_w=wh[0];
		self.resize_h=wh[1];
	end
end
