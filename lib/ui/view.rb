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

	def put(*args,**_)
		@view.put(*args,**_)
	end

	def erase(x,y)
		@view.erase(x,y);
	end

	def clear
		@view.clear;
	end

	def redraw
		#$console.log("Redraw UI::View");
		@view.redraw;
	end

	def change
		# Resize the view
		#$console.log("UI::View resized; resize VIEW to #{@wh}");
		@view.xy=[@@view.xy[0]+@xy[0],@@view.xy[1]+@xy[1]];
		@view.resize(*@wh);
	end

	def initialize(scene=nil,**_)
		super(**_);
		x,y=@xy;
		@view=View.new(*@wh,x:x,y:y,scene:scene,screen:@@view.screen);
	end
end
