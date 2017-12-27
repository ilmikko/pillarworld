Thread.abort_on_exception=true;

require('io/console');

class Screen
	@@screens=[];
	def self.resize(wh)
		@@screens.each{|screen|
			screen.resize(wh);
		}
	end

	def wh;
		@wh
	end
	def width;
		@wh[0];
	end
	def height;
		@wh[1];
	end
	def clear
		print("\e[2J");
	end
	def onresize(func)
		@onresize.push(func);
	end

	def put(x,y,char,color: nil)
		return if x<0 or y<0;
		print(color) if color.is_a? Screen::Color;
		print("\e[" << (y.round.to_i+1).to_s << ';' << (x.round.to_i+1).to_s << 'H' << char.to_s);
	end

	def erase(x,y)
		put(x,y,' '); # for now
	end

	def resize(wh)
		@wh=wh;

		clear;

		# Fire event
		@onresize.each{|func|
			func.();
		}
	end

	#######
	private
	#######

	def initialize
		@onresize=[];
		@wh=$stdin.winsize.reverse;
		clear;
		@@screens.push(self);
		$console.warn("There are currently #{@@screens.length} screens active (an application needs only one in most cases)!") if @@screens.length>1;
	end
end

require('screen/color');
require('screen/resize');
require('screen/text');
require('screen/lines');
