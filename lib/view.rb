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
	@@screen=Screen.new;
	def self.screen=(screen);
		@@screen=screen;
	end
	def self.screen;
		@@screen;
	end

	include Tool::Evented;
	include Tool::Resizable;
	include Tool::Positionable;

	attr_reader :screen;

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

	def set(**sets)
		# TODO: We don't have to create a new screen state for every single set, because usually we will set `nil` or `color: :black` or something similar
		# Thus, we can improve our performance if we cache the state options and use a generated state for only one set of options.

		if sets.nil? or sets.empty?
			state=Screen::State.default;
		else
			state=Screen::State.new(**sets);
		end

		@screen.use(state);
	end

	def erase(x,y)
		# Erase got its own private function as using _put causes the erase to get cached, what we don't want
		x,y=_round(x,y);
		return false if _outside?(x,y);
		@screen.put(@x+x,@y+y,' ');
		return true;
	end

	# Destroying a view, for example if we leave a menu screen or something, we don't want the fps thread to keep living without the view.
	def destroy()
		# Destroy the event
		@screen.off(@event);
		# TODO: Anything more to destroy?
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

		#$console.log("#{self} PUT #{char} to #{[x,y]} in #{[@w,@h]}!");

		return false if _outside?(x,y);

		#$console.log("#{self} PUT #{char} to #{[x,y]}!");

		# Cache the current character and color to be put on screen
		# FIXME: Currently only saving write positions.
		# TODO: What about \e[7m, bold and so on?
		@cache.write(x,y,char);

		@screen.put(@x+x,@y+y,char);
		return true;
	end

	def initialize(w=nil,h=nil,x:0,y:0,screen:@@screen,scene:nil)
		@x,@y,@w,@h=x,y,w,h;

		@cache=View::Cache.new;
		@screen=screen;

		if w==nil and h==nil
			$console.log("Resizing to the screen with available space...");
			self.wh=[screen.w-x,screen.h-y];
		end

		# If we haven't defined a width & height, assume that we want full screen.
		# Otherwise keep the width & height of the view static.
		# TODO: this is wrong - the view should never resize to the full screen, unless it's a UI element.
		# However, until the UI is properly made stable, this is what we have to make do with.
		if w.nil? or h.nil?
			$console.log("Attaching a resize event for #{self}... (redraw & resize)");
			@event=screen.on('resize',->{
				$console.log("redraw & resize fired for #{self}");
				# TODO: Do you need the clear/redraw functions?
				clear;
				self.wh=[screen.w-x,screen.h-y];
				redraw;
				fire('resize');
			});
		else
			$console.log("Attaching a resize event for #{self}... (redraw)");
			@event=screen.on('resize',->{
				clear;
				redraw;
				fire('resize');
			});
		end

		self.scene=scene if !scene.nil?;
	end
end

require('view/cache');
require('view/text');
require('view/draw');
require('view/performance');
