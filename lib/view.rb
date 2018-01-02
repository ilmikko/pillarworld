# 
# View < Screen
#
# Basically there is only one Screen which is the whole terminal screen.
# But this screen can be divided into multiple Views, independent of any UI layouts or other inconveniences.
# A View only cares about the absolute pixel position and width it has on the Screen.
#

require('screen');

class View
	def scene=(v)
		@scene=v;

		# Redraw the view when the scene changes
		redraw;
	end

	attr_reader :w,:h

	def wh;[@w,@h];end

	# Resize when the size changes (resize redraws)
	def w=(v);
		@w=v;
		resize;
	end
	def h=(v);
		@h=v;
		resize;
	end
	def wh=(wh);
		@w,@h=wh;
		resize;
	end

	# What to do when the view resizes
	def resize
		$console.log("View registered a resize event: #{[@w,@h]}");
		redraw;
	end

	alias width w
	alias width= w=
	alias height h
	alias height= h=

	attr_reader :x,:y
	def xy;[@x,@y];end

	# Redraw when position changes (clear the old position before that?)
	def x=(v);
		clear;
		@x=v;
		redraw;
	end
	def y=(v);
		clear;
		@y=v;
		redraw;
	end
	def xy=(xy)
		clear;
		@x,@y=xy;
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

	def write(x,y,str,**sets)
		# TODO: write centered or right-aligned?
		len=str.length;

		# TODO: Get the bounds - sometimes we don't need to loop through the entire string.
		set(**sets);

		for i in 0...len
			# Break if put fails, because that means it's out of bounds
			# TODO: What about if we start from behind?
			_put(x+i,y,str[i]);
		end
	end

	def set_color(color)
		#if color
		#	col=color.to_s;
		#	$console.log("Setting color to #{col}");
		#	print("\e[#{col}m");
		#else
		#	print("\e[m") # HACK: reset the modifiers
		#end
	end

	def set_modifiers(mods)
		#print("\e[#{mods.join(';')}m");
	end

	def set(**sets)
		$console.log("Forcing set: #{sets}");
		modifiers=Screen::State.new(**sets);
		$console.log("Set: #{modifiers}");
		print(modifiers);
		#set_color(sets[:color]);
		#print(Screen::Modifier.negate) if sets[:negate];
		#print(Screen::Modifier.bold) if sets[:bold];
		#print(Screen::Modifier.faint) if sets[:faint];
		#print(Screen::Modifier.italic) if sets[:italic];
		#print(Screen::Modifier.underline) if sets[:underline];
	end

	def put(x,y,char,**sets)
		x,y=_round(x,y);
		# Cache optimizations - we don't need to clear the whole screen
		# (and in fact, a single View should never clear a whole Screen)
		#
		# Return if we have this particular one already cached
		# return if cached?(x,y); (TODO: This is still buggy as we need to check color as well)
		set(**sets);

		_put(x,y,char);
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
		#$console.log("Outside of the view? x:#{x} y:#{y} w:#{@w} h:#{@h} -> #{x<0 or y<0 or x>=@w or y>=@h}");
		# Prevent writing outside of the view
		return true if x<0 or y<0 or x>=@w or y>=@h;
		return false;
	end

	def _put(x,y,char)
		# We need these for caching
		
		return false if _outside?(x,y);

		# Cache the current character and color to be put on screen
		# FIXME: Currently only saving write positions.
		# TODO: What about \e[7m, bold and so on?
		@cache.write(x,y);
		
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

				if w==0 and h==0
					$console.log("Resizing to the created screen...");
					self.wh=screen.wh;
				end
			end
		end

		# If we haven't defined a width & height, assume that we want full screen.
		# Otherwise keep the width & height of the view static.
		if w.nil? or h.nil?
			$console.log("Attaching a resize event... (redraw & resize)");
			screen.on('resize',->{
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
require('view/performance');
