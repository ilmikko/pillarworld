#
#	screen/color
#
#	Color handling library for different terminal screens.
#	Has the ability to choose the appropriate ANSI codes in case one isn't currently supported.
#	Abstracts the handling of color in screens so that we can use any color we want, and even in 16-color terminals still display the
#	most appropriate color.
#

# We have a couple of different ways of representing colors.
# The most obvious ones are:
# foreground color
# background color
#
# But there are also some others that modify the colors / visuals, like:
# bold
# faint (maybe)
# italic (not widely supported)
# underline
# negative (reverse video)
#

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
		$console.log("Setting color mode to #{v}...");
		$console.warn("Changing the color mode multiple times is not recommended, as it may lead to unexpected behavior.") if @@mode!=:none;
		if v==:optimal
			include Screen::Color::Optimal
		elsif v==:reduced
			include Screen::Color::Reduced
		elsif v==:bare
			include Screen::Color::Bare
		elsif v==:system
			include Screen::Color::System
		else
			raise "Unknown color mode: #{v}";
		end
		@@mode=v;
	end

	module Screen::Color::Defaults
		def recalc
			@colstr=convert(@r,@g,@b).join(';');
		end
	end

	module Screen::Color::Optimal
		include Screen::Color::Defaults
		def convert(r,g,b)
			[38,2,r,g,b];
		end
		def convert_bg(r,g,b)
			[48,2,r,g,b];
		end
	end

	module Screen::Color::Reduced
		include Screen::Color::Defaults
		def convert(r,g,b)
			r/=51;
			g/=51;
			b/=51;

			[38,5,16+r*36+g*6+b];
		end
		def convert_bg(r,g,b)
			r/=51;
			g/=51;
			b/=51;

			[48,5,16+r*36+g*6+b];
		end
	end

	module Screen::Color::Bare
		include Screen::Color::Defaults
		def convert(r,g,b)
			r/=128;
			g/=128;
			b/=128;

			i=r+g*2+b*4;

			if i>0;
				[90+i];
			else
				[0,30]; # Black is still black. FIXME: This resets everything, shouldn't this be 22 instead of 0?
			end
		end

		def convert_bg(r,g,b)
			r/=128;
			g/=128;
			b/=128;

			i=r+g*2+b*4;

			if i>0;
				[100+i];
			else
				[0,40]; # Black is still black. FIXME: This resets everything, shouldn't this be 22 instead of 0?
			end
		end
	end

	module Screen::Color::System
		include Screen::Color::Defaults
		def convert(r,g,b)
			r/=128;
			g/=128;
			b/=128;

			[30+r+g*2+b*4];
		end
		def convert_bg(r,g,b)
			r/=128;
			g/=128;
			b/=128;

			[40+r+g*2+b*4];
		end
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
			arg=args[0];
			if arg.is_a? Symbol
				self.new(*@@colors[args[0]]);
			elsif arg.is_a? Screen::Color
				arg
			else
				raise "Cannot parse color: #{arg}";
			end
		elsif args.length==3
			# Assume r,g,b
			self.new(*args);
		else
			raise "Cannot parse color: #{args}";
		end
	end

	attr_reader :r,:g,:b

	def rgb;
		[@r,@g,@b];
	end

	def r=(v);@r=v;recalc;end
	def g=(v);@g=v;recalc;end
	def b=(v);@b=v;recalc;end

	def initialize(r,g,b)
		# Reduce this to an ANSI color - this way we can then check for color overlaps in screen
		@r,@g,@b=r,g,b;
		recalc;
	end

	def to_s
		@colstr||''
	end
end

class Screen::Background < Screen::Color
	def recalc
		@colstr=convert_bg(@r,@g,@b).join(';');
	end
end
