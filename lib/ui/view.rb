# 
# UIView
# A custom UI element where you can draw interactively.
# The view is supposed to be updated every tick (i.e. 60fps), and is the heaviest element in terms of performance.
# Doesn't support states; i.e. when the screen reflows, the view should be able to redraw itself.
# This is done by scenes.
# If you want something that remembers the state of pixels, you should probably be using UICanvas instead.
#

class UI::View < UI::Node
	def scene=(v)
		@scene=v;
		redraw; # Always redraw when scene changes
	end

	def put(x,y,char)
		w,h=@wh;
		return if x<0 or y<0 or x>=w or y>=h; # Prevent writing outside of the view

		sx,sy=@xy;
		@@screen.put(sx+x,sy+y,char);
	end

	def redraw
		#$console.log("Redrawing #{self} with scene #{@scene}");
		@scene.() if @scene;
	end

	def initialize(scene=nil,**_)
		super(**_);
		self.scene=scene if !scene.nil?;
	end
end
