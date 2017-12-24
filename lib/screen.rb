Thread.abort_on_exception=true;

require('io/console');

class Screen
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

	def put(x,y,char)
		return if x<0 or y<0;
		print("\e[" << (y.round.to_i+1).to_s << ';' << (x.round.to_i+1).to_s << 'H' << char.to_s);
	end

	#######
	private
	#######

	def initialize
		print("\e[?25l");
		@onresize=[];
		@wh=$stdin.winsize.reverse;

		# New thread for resizing check
		Thread.new{
			lastwinsize=nil;
			loop{
				# Resize check, every n frames
				if ($stdin.winsize!=lastwinsize)
					lastwinsize=$stdin.winsize;
					@wh=lastwinsize.reverse;
					clear;
					resize;
				end

				# Everyone needs some rest
				sleep(1.0/60.0);
			}
		}
		at_exit{
			close;
		}
		clear;
	end
	def resize
		@onresize.each{|func|
			func.();
		}
	end
	def close
		clear;
		print("\e[?25h");
	end
end

require_relative 'screen/text'
require_relative 'screen/lines'
