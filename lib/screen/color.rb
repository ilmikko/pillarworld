#
#	screen/color
#
#	Color handling library for different terminal screens.
#	Has the ability to choose the appropriate ANSI codes in case one isn't currently supported.
#	Abstracts the handling of color in screens so that we can use any color we want, and even in 16-color terminals still display the
#	most appropriate color.
#

class Screen
	def color=(v)
		print(Screen::Color[v]);
	end
end

class Screen::Color
	@@colors={
		black: [0,0,0],
		red: [255,0,0],
		green: [0,255,0],
		blue: [0,0,255],
		yellow: [255,255,0],
		cyan: [0,255,255],
		magenta: [255,0,255],
		white: [255,255,255]
	};

	def self.[](*args)
		if args.length==1
			#return args[0] if args[0].is_a? Screen::Color;
			# Assume symbol
			$console.warn("#{args[0]} -> #{@@colors[args[0]]}");
			self.new(*@@colors[args[0]]);
		elsif args.length==3
			# Assume r,g,b
			self.new(*args);
		else
			throw "Cannot parse color: #{args}";
		end
	end

	def to_s
		@colstr
	end

	def initialize(r,g,b)
		# Reduce this to an ANSI color - this way we can then check for color overlaps in screen
		@original=[r,g,b];
		@colstr="\e[38;2;#{r};#{g};#{b}m";
	end
end

class Color < Screen::Color
end
