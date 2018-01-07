class View
	def write(x,y,str,**sets)
		len=str.length;

		set(**sets);

		for i in 0...len
			# TODO: Break if put fails to increase performance
			# e.g. if we're trying to write out of view, we're either on the
			# left or right side of it and we can skip the rest.
			_put(x+i,y,str[i]);
		end
	end
end
