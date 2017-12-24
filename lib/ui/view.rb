# 
# UIView
# A custom UI element where you can draw interactively.
# The view is supposed to be updated every tick (i.e. 60fps), and is the heaviest element in terms of performance.
# Doesn't support states; i.e. when the screen reflows, the view should be able to redraw itself.
# This is done by scenes.
# If you want something that remembers the state of pixels, you should probably be using UICanvas instead.
#

class UI::View < UI::Node
	attr_reader :fps

	def scene=(v)
		@scene=v;
		redraw; # Always redraw when scene changes
	end

	def put(x,y,char)
		w,h=@wh;
		x=x.round;
		y=y.round;
		return if x<0 or y<0 or x>=w or y>=h; # Prevent writing outside of the view
		
		# Return if we already have this in the cache (trying to rewrite a cell)
		return if @clearcache["#{x},#{y}"]==char;
		# Store in cache
		@clearcache["#{x},#{y}"]=char;

		sx,sy=@xy;
		@@screen.put(sx+x,sy+y,char);
	end

	def clear
		# TODO: clearing in different situations
		sx,sy=@xy;
		@clearcache.dup.each{|k,v|
			$console.log("#{k}->#{v}");
			x,y=k.split(",");
			@@screen.erase(sx+x.to_i,sy+y.to_i);
		}
		reset;
	end

	def reset
		# Reset the clearing cache
		@clearcache={};
	end

	def change
		# When our attributes change, the screen has redrawn and we need to reset our clearing cache.
		reset;
	end

	def redraw(timedelta=0)
		#$console.log("Redrawing #{self} with scene #{@scene}");
		if @scene
			if @scene.arity>0
				# Pass the time delta if the scene accepts arity
				@scene.(timedelta);
			else
				# Else just call with no arguments
				# TODO: In this case, we're having timestamps in the fps thread which are utterly useless.
				# Please FIXME.
				@scene.();
			end
		end
	end

	def initialize(scene=nil,fps:-1,**_)
		@fps=fps;

		@clearcache={};
		
		if fps>0
			$console.log("View #{self} creates an fps thread with fps=#{@fps}");
			Thread.new{
				stamp=Time.now;
				loop{
					clear;
					redraw(Time.now-stamp);
					slp=1/@fps.to_f;
					stamp=Time.now;
					sleep(slp);
				}
			}
		end

		super(**_);
		self.scene=scene if !scene.nil?;
	end
end
