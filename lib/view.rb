# 
# View
#
# Basically there is only one Screen which is the whole terminal screen.
# But this screen can be divided into multiple Views, independent of any UI layouts or other inconveniences.
# A View only cares about the absolute pixel position and width it has on the Screen.
#

require('screen');

require('tool/evented');
require('tool/resizable');
require('tool/positionable');

class View
	include Tool::Evented;
	include Tool::Resizable;
	include Tool::Positionable;

	def scene=(v)
		@scene=v;

		# Redraw the view when the scene changes
		redraw;
	end

	def clear
		# TODO: Clearing optimizations
		@cache.each_write{|x,y|
			erase(x,y);
		}
		@cache.look_at_writes;
		@cache.clear_writes;
	end

	def redraw
		@scene.call if !@scene.nil?;
	end

#	def write(x,y,str,**sets)
#		# TODO: What's the difference between screen.write and view.write?
#		# TODO: write centered or right-aligned?
#		len=str.length;
#
#		# TODO: Get the bounds - sometimes we don't need to loop through the entire string.
#		set(**sets);
#
#		for i in 0...len
#			# Break if put fails, because that means it's out of bounds
#			# TODO: What about if we start from behind?
#			_put(x+i,y,str[i]);
#		end
#	end

	#def set_color(color)
	#	#if color
	#	#	col=color.to_s;
	#	#	$console.log("Setting color to #{col}");
	#	#	print("\e[#{col}m");
	#	#else
	#	#	print("\e[m") # HACK: reset the modifiers
	#	#end
	#end

	#def set_modifiers(mods)
	#	#print("\e[#{mods.join(';')}m");
	#end

	def set(**sets)
		# TODO: do we need this?
		$console.log("#{self} sets screen #{@screen}");
		@screen.set(**sets);
	end

	# NOTE: This has been commented out because getting stuff from the view is really unreliable.
	# There is probably always a better method than just a plain "get whatever I have put there previously".
	# Also this will degrade performance even if you're not using it, because you would have to store
	# EVERY WRITE EVER just because someone MIGHT need ONE THING from it sometime.
	#def get
	#	# TODO: A way to get a drawn character and/or it's color?
	#end

	def erase(x,y)
		# Erase got its own private function as using _put causes the erase to get cached, what we don't want
		x,y=_round(x,y);
		return false if _outside?(x,y);
		@screen.put(@x+x,@y+y,' ');
		return true;
	end

	#######
	private
	#######
	
	def _round(x,y)
		x=x.round.to_i;
		y=y.round.to_i;
		return [x,y];
	end

	def _outside?(x,y)
		#$console.log("Outside of the view? x:#{x} y:#{y} w:#{@w} h:#{@h}");
		# Prevent writing outside of the view
		return true if x<0 or y<0 or x>=@w or y>=@h;
		return false;
	end

	def _put(x,y,char)
		# We need these for caching
		x,y=_round(x,y);
		
		return false if _outside?(x,y);

		# Cache the current character and color to be put on screen
		# FIXME: Currently only saving write positions.
		# TODO: What about \e[7m, bold and so on?
		@cache.write(x,y,char);
		
		# TODO: instead of this, we could cache the writes over to our FPS thread.
		@screen.put(@x+x,@y+y,char);
		return true;
	end

	def initialize(w=nil,h=nil,x:0,y:0,screen:nil,scene:nil)
		@x,@y,@w,@h=x,y,w,h;

		@cache=View::Cache.new;

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

		if w==nil and h==nil
			$console.log("Resizing to the screen with available space...");
			self.w=screen.w-x;
			self.h=screen.h-y;
		end

		# If we haven't defined a width & height, assume that we want full screen.
		# Otherwise keep the width & height of the view static.
		if w.nil? or h.nil?
			$console.log("Attaching a resize event... (redraw & resize)");
			screen.on('resize',->{
				$console.log("redraw & resize fired for #{self}");
				self.wh=screen.wh;
			});
		else
			$console.log("Attaching a resize event... (redraw)");
			screen.on('resize',->{
				redraw;
			});
		end

		@screen=screen;

		self.scene=scene if !scene.nil?;
	end
end

require('view/cache');
require('view/text');
require('view/draw');
require('view/performance');
