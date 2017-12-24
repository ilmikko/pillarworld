# 
# UINode
# Contains public functions every element should have.
# Every UI element inherits UINode.
#

class UI::Node
	def color;@color;end
	def color=(v);
		if (v.is_a? String)
			@color=v;
		elsif (v.is_a? Symbol)
			@color=@@colors[v];
		elsif (v.nil?)
			@color=nil;
		end
	end

	def id;@id;end
	def id=(v);@id=v;end

	def change;end # Hook for when something has changed

	def initialize(id: nil,width:nil,height:nil)
		@id=id;
		@xy=[0,0];
		@wh=[0,0];
		@preferredwh=[width,height];
	end

	# Redraw: when there is a need for a redraw (for example, the text has changed)
	# Old update
	def redraw
		if !@write.nil? && !@@canvas.nil?
			$console.debug("Write (no debug)");
			@@canvas.write(*@xy,@write,color:@color);
		end
	end
end

require 'ui/node/hierarchy'
require 'ui/node/positioning'
require 'ui/node/debug'