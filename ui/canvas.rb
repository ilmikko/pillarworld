Thread.abort_on_exception=true;

require('io/console');

class Canvas
	def wh;
		@wh
	end
	def clear
		print("\e[2J");
	end
	def onresize(func)
		@onresize.push(func);
	end
	def put(x,y,char)
		print("\e[" << (y.to_i+1).to_s << ';' << (x.to_i+1).to_s << 'H' << char.to_s);
	end

	#######
	private
	#######

	def initialize
		clear;
		print("\e[?25l");
		@onresize=[];
		@wh=[0,0];

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

require_relative('canvas-text');
require_relative('canvas-lines');
