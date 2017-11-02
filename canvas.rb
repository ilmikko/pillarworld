require('./screen.rb');

# TODO: Maybe in the future instead of doing a direct write we can queue the writes and every frame then order them so that we won't be changing colors and settings etc and the drawing is optimized.
# That was a very awkward sentence so let me try again:
# Suppose you have a string AbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAbAb.
# Every A is green and b is blue. Naively we would go from left to right and change colors in between every step. What could happen instead
# Was that the string was separated by color, and we would wait until a certain point in time (say 1ms) to then render everything by color.
# So the green things would render first, then the blue.

class Canvas
	@@screen=$screen;
	@@default_color="\e[0m";

	def screen;@@screen;end

	def draw(x,y,str,color: @@default_color)
		@@screen.put(x,y,color+str);
	end
	def initialize()
		@colors={};
	end
end

$canvas=Canvas.new();
