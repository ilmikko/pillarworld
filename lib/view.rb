# 
# View < Screen
#
# Basically there is only one Screen which is the whole terminal screen.
# But this screen can be divided into multiple Views, independent of any UI layouts or other inconveniences.
# A View only cares about the absolute pixel position and width it has on the Screen.
#

require('screen');

Screen::Color.mode=:reduced;

require('view/caching');

class View
	attr_reader :w,:h

	alias width w
	alias height h

	def scene=(v)
		@scene=v;
		redraw;
	end

	def wh=(wh)resize(*wh);end
	def xy=(xy)
		@x,@y=xy;
	end

	def resize(w,h)
		$console.log("#{self} resizing from #{[@w,@h]} to #{[w,h]}");
		@w,@h=w,h;
	end

	def redraw
		@scene.call if !@scene.nil?;
	end

	def wh;[@w,@h];end

	def put(x,y,char,color: nil)
		print(color.to_s) if !color.nil?;

		# We need these for caching
		x=x.round.to_i if !x.is_a? Integer;
		y=y.round.to_i if !y.is_a? Integer;

		$console.log("Outside of the view? x:#{x} y:#{y} w:#{@w} h:#{@h}");
		# Prevent writing outside of the view
		return false if x<0 or y<0 or x>=@w or y>=@h;
		
		# TODO: instead of this, we could cache the writes over to our FPS thread.
		@screen.put(@x+x,@y+y,char);
		return true;
	end

	def get
		# TODO: A way to get a drawn character and/or it's color?
	end

	def erase(x,y)
		put(x,y,' ');
	end

	def initialize(x,y,w,h,screen:nil,scene:nil)
		@x,@y,@w,@h=x,y,w,h;

		if screen.nil?
			# CONVENIENCE: Check if there are any active Screens.
			list=Screen.list;
			$console.log("Screen was nil; I see #{list.length} active screen(s).");
			if list.length>0
				screen=list.last;
				$console.log("Attached to the last screen (#{screen})");
			else
				$console.log("Creating a new screen and attaching...");
				screen=Screen.new;
			end
		end

		@screen=screen;

		screen.on('resize',->{
			redraw;
		});

		self.scene=scene if !scene.nil?;
	end
end

require('view/performance');
