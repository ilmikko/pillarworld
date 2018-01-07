class Screen
	def write(x,y,str)
		w,h=@w,@h;
		return if (x<-str.length+1||x>=w||y>=h||y<0); # Starting point out of bounds

		# under/overflow prevention
		if (x<0)
			str=str[-x..-1];
			x=0;
		end

		if (x+str.length>w)
			str=str[0..w-x-1];
		end

		x=(x+1).round.to_i;
		y=(y+1).round.to_i;

		# HACK: Clear colors before writing
		$console.log("Screen: Write #{str}");
		$stdout.write("\e[" << y.to_s << ';' << x.to_s << 'H' << str.to_s);
	end
end
