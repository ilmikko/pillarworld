Thread.abort_on_exception=true;

require('io/console');
require('evented');

class Screen
	include Evented
	@@screens=[];
	def self.list
		@@screens
	end
	def self.resize(w,h)
		@@screens.each{|screen|
			screen.resize(w,h);
		}
	end

	def resize(w,h)
		@w,@h=w,h;

		clear;

		# Fire event
		fire('resize');
	end

	def wh;
		[@w,@h];
	end
	def width;
		@w;
	end
	def height;
		@h;
	end
	def clear
		print("\e[2J");
	end

	def put(x,y,char)
		x=x.round.to_i+1;
		y=y.round.to_i+1;
		return if x<0 or y<0 or x>@w or y>@h;
		print("\e[" << y.to_s << ';' << x.to_s << 'H' << char.to_s);
	end

	#######
	private
	#######

	def initialize
		@w,@h=$stdin.winsize.reverse;
		clear;

		@@screens << self;

		$console.warn("There are currently #{@@screens.length} screens active (an application needs only one in most cases)!") if @@screens.length>1;
	end
end

require('screen/color');
require('screen/resize');
require('screen/text');
require('screen/lines');
