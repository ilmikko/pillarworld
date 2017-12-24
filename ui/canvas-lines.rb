class Canvas
	def hline(x,y,w,char: '#')
		return if !char.is_a? String or char.empty? or w==0;

		if (w<0)
			put(x+w,y,char*(-w+1));
		else
			put(x,y,char*w);

			# HACK: This is one solution to combat a calculation mistake in the rounding errors for floating points.
			# Sometimes the width is one point less than what we originally intended due to the fact that
			# 0.33333333+0.66666666 < 1. You can see this by commenting this line out (or replacing the character)
			# and running test/border.rb
			#
			# The reason this is not present in vline is because we use a different solution (namely, a for loop).
			put(x+w-1,y,char);
		end
	end

	def vline(x,y,h,char: '#')
		return if !char.is_a? String or char.empty?;
		y=y.round.to_i;
		h=h.round.to_i;
		# If someone has a better solution let me know
		if (h<0)
			for y in y+h+1...y+1
				put(x,y,char);
			end
		else
			for y in y...y+h
				put(x,y,char);
			end
		end
	end
end
