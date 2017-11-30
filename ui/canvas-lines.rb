class Canvas
	def hline(x,y,w,char: '#')
		return if !char.is_a? String or char.empty?;
		w=w.round.to_i;
		if (w<0)
			put(x+w+1,y,char*(-w));
		else
			put(x,y,char*w);
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
