require_relative('./screen.rb');

# TODO: Maybe in the future instead of doing a direct write we can queue the writes and every frame then order them so that we won't be changing colors and settings etc and the drawing is optimized.
# That was a very awkward sentence so let me try again:
# Suppose you have a string AbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAb.
# Every A is green and b is blue. Naively we would go from left to right and change colors in between every step. What could happen instead
# Was that the string was separated by color, and we would wait until a certain point in time (say 1ms) to then render everything by color.
# So the green things would render first, then the blue.

class Canvas
	@@screen=$screen;
	@@default_color="\e[0m";

	def color(v)
		@@screen.printf(v);
	end
	def endcolor()
		@@screen.printf(@@default_color);
	end

	def write(x,y,str,**_)
		@@screen.write(x,y,str,**_);
	end

	def draw(x,y,char: '#')
		@@screen.put(x,y,char);
	end

	def hline(x,y,w,char: '#')
		w=w.round.to_i;
		if (w<0)
			@@screen.put(x+w+1,y,char*(-w));
		else
			@@screen.put(x,y,char*w);
		end
	end

	def vline(x,y,h,char: '#')
		y=y.round.to_i;
		h=h.round.to_i;
		# If someone has a better solution let me know
		if (h<0)
			for y in y+h+1...y+1
				@@screen.put(x,y,char);
			end
		else
			for y in y...y+h
				@@screen.put(x,y,char);
			end
		end
	end

	def initialize()
	end
end

$canvas=Canvas.new();
