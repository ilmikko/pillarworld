# 
# UIView
# A custom UI element where you can draw interactively.
# The view is supposed to be updated every tick (i.e. 60fps), and is the heaviest element in terms of performance.
# Doesn't support states; i.e. when the screen reflows, the view should be able to redraw itself.
# This is done by scenes.
# If you want something that remembers the state of pixels, you should probably be using UICanvas instead.
#

# FIXME: The methods of View resemble the methods of Screen a lot.

class UI::View < UI::Node
	attr_reader :fps

	def scene=(v)
		@view.scene=v;
	end

	def put(x,y,char,color:nil)
		@view.put(x,y,char,color:color);
	end

	def erase(x,y)
		@view.erase(x,y);
	end

	def clear
		@view.clear;
	end

	def redraw
		@view.redraw;
	end

	def change
		# when our attributes change, we need to redraw the view (whose job is this?)
		# TODO:
		$console.log("UI::View resized to #{@wh}");
		@view.xy=@xy;
		@view.wh=@wh;
	end

	def initialize(scene=nil,fps:-1,**_)
		super(**_);
		@view=View::Performance.new(*@xy,*@wh,scene:scene,screen:@@screen,fps:fps);
	end
end
