Thread.abort_on_exception=true;

require('io/console');

require('tool/evented');
require('tool/resizable');

class Screen
	include Tool::Evented
	include Tool::Resizable

	@@screens=[];
	def self.list
		@@screens
	end
	def self.resize(w,h)
		$console.log("Master screen resize event fired");
		@@screens.each{|screen|
			screen.clear;
			screen.resize(w,h);
			screen.fire('resize');
		}
	end

	def clear
		$stdout.print("\e[2J");
	end

	def use(state)
		state=state.to_s if state.is_a? Screen::State;
		raise "Cannot use state: #{state}" if !state.is_a? String;
		$console.log("Using state: #{state}");
		$stdout.print(state.to_s);
	end

	def set(**sets)
		$console.log("Screen: set: #{sets}");
		# TODO: Do we need to create a new state every time?
		modifiers=Screen::State.new(**sets);
		$stdout.print(modifiers);
	end

	def put(x,y,char)
		x=x.round.to_i+1;
		y=y.round.to_i+1;
		return if x<0 or y<0 or x>@w or y>@h;
		$stdout.print("\e[" << y.to_s << ';' << x.to_s << 'H' << char.to_s);
	end

	#######
	private
	#######

	def initialize
		@w,@h=$stdin.winsize.reverse;
		clear;

		# Set the screen to our default state
		@state=Screen::State.default;
		use(@state);

		@@screens << self;

		$console.warn("There are currently #{@@screens.length} screens active (an application needs only one in most cases)!") if @@screens.length>1;
	end
end

require('screen/color');

Screen::Color.mode=:reduced; # for now.

require('screen/modifiers');
require('screen/state');
require('screen/resize');
require('screen/text');
