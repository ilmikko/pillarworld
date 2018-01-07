# 
# UINode
# Contains public functions every element should have.
# Every UI element inherits UINode.
#

class UI::Node
	attr_accessor :id

	def change;end # Hook for when something has changed

	def initialize(id: nil,width:nil,height:nil)
		@id=id;
		@xy=[0,0];
		@wh=[0,0];
		@preferred_wh=[nil,nil];
		$console.log("Set p_wh to #{[width,height]}");
		self.p_w=width if !width.nil?;
		self.p_h=height if !height.nil?;
	end

	# Redraw: when there is a need for a redraw (for example, the text has changed)
	# Old update
	def redraw
		if !@write.nil? && !@@screen.nil?
			$console.debug("Write (no debug)");
			@@screen.write(*@xy,@write);
		end
	end
end

require('ui/node/debug');
require('ui/node/hierarchy');
require('ui/node/positioning');
