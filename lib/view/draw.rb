class View
	def bounds(x,y,w,h,text)
		# Debug bounds, extremely useful
		write(x,y,"<#{text}");
		write(x+w-1-text.length,y+h-1,"#{text}>");
	end

	def hline(x,y,w,char: '#')
		return if char.empty? or w==0;

		# y out of bounds
		return if y < 0 or y > @h;

		# Check if out of bounds
		return if x+w < 0 or x > @w;

		# Check if crop
		if x < 0 or x+w > @w
			if x < 0
				# Left crop
				return hline(0,y,w+x,char:char);
			else
				# Right crop
				return hline(x,y,@w-x,char:char);
			end
		end

		# Safe to put
		_put(x,y,char*w);

		# HACK: This is one solution to combat a calculation mistake in the rounding errors for floating points.
		# Sometimes the width is one point less than what we originally intended due to the fact that
		# 0.33333333+0.66666666 < 1. You can see this by commenting this line out (or replacing the character)
		# and running test/border.rb
		#
		# The reason this is not present in vline is because we use a different solution (namely, a for loop).
		_put(x+w-1,y,char);
	end

	def vline(x,y,h,char: '#')
		return if char.empty? or h==0;

		# X out of bounds
		return if x < 0 or x > @w;

		

		y=y.round.to_i;
		h=h.round.to_i;
		# If someone has a better solution let me know
		if (h<0)
			for y in y+h+1...y+1
				_put(x,y,char);
			end
		else
			for y in y...y+h
				_put(x,y,char);
			end
		end
	end

	def put(x,y,char,**sets)
		# Cache optimizations - we don't need to clear the whole screen
		# (and in fact, a single View should never clear a whole Screen)
		#
		# Return if we have this particular one already cached
		# return if cached?(x,y); (TODO: This is still buggy as we need to check color as well)
		set(**sets) if sets;

		_put(x,y,char);
	end
end
