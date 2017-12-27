#
#	screen/color
#
#	Color handling library for different terminal screens.
#	Has the ability to choose the appropriate ANSI codes in case one isn't currently supported.
#	Abstracts the handling of color in screens so that we can use any color we want, and even in 16-color terminals still display the
#	most appropriate color.
#

class Screen::Color
	module Screen::Color::Defaults
		def convert(r,g,b)
			"\e[31m"
		end
		def initialize(r,g,b)
			# Reduce this to an ANSI color - this way we can then check for color overlaps in screen
			@original=[r,g,b];
			@colstr=convert(r,g,b);
		end
	end

	module Screen::Color::Reduced
		include Screen::Color::Defaults
		def convert(r,g,b)
			r/=5;
			g/=5;
			b/=5;

			"\e[38;5;" << (16+r*36+g*6+b) << 'm';
		end
	end

	module Screen::Color::Optimal
		include Screen::Color::Defaults
		def convert(r,g,b)
			"\e[38;2;" << r.to_s << ';' << g.to_s << ';' << b.to_s << 'm';
		end
	end

	module Screen::Color::Bare
		include Screen::Color::Defaults
		def convert(r,g,b)
			''
		end
	end
end

class Screen::Color
	@@mode=:none;
	def self.mode;@@mode;end
	def self.mode=(v)
		#
		# As we're playing with Ruby's include, a module can only be included once into the program.
		# This means that if you were to do
		# ```
		# Screen::Color.mode=:optimal
		# Screen::Color.mode=:reduced
		# Screen::Color.mode=:optimal
		# ```
		# The color mode would stay in reduced as optimal has already been included here.
		# Currently it's not an issue as the color mode should NOT be changed after the init;
		# however, I might add a 'force' option later in the case that we do need to
		# cycle through the color modes, for example in the settings.
		#
		$console.warn("Changing the color mode multiple times is not recommended, as it may lead to unexpected behavior.") if @@mode!=:none;
		$console.log("Setting color mode to #{v}...");
		if v==:optimal
			include Screen::Color::Optimal
		elsif v==:reduced
			include Screen::Color::Reduced
		elsif v==:bare
			include Screen::Color::Bare
		else
			raise "Unknown color mode: #{v}";
		end
		@@mode=v;
	end

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
			self.new(*@@colors[args[0]]);
		elsif args.length==3
			# Assume r,g,b
			self.new(*args);
		else
			throw "Cannot parse color: #{args}";
		end
	end

	def to_s
		@colstr||''
	end
end
