# 
# UINode
# Contains public functions every element should have.
# Every UI element inherits UINode.
#

class UI::Node
	attr_accessor :id;

	# TODO: Rename this to 'changed' or alternatively make it an event.
	def change;end # Hook for when something has changed

	def initialize(id: nil, width: nil, height: nil, **sets)
		@id=id;
		@xy=[0,0];

		# Size and resizing
		@wh=[0,0];
		@max_wh=[nil,nil];
		@min_wh=[nil,nil];

		#$console.log("Set p_wh to #{[width,height]}");
		self.width=width if !width.nil?;
		self.height=height if !height.nil?;

		# FIXME: The code is getting dirty - in order to improve the performance and the code itself,
		# we need another layer between UI elements and the Screen (or view, which we don't really need)
		# so that an UI element can't just access the Screen or manage it's States, because that's just
		# stupid in the long run.
		@state=Screen::State.new(**sets) if sets;
	end
end

require('ui/node/drawing');
require('ui/node/hierarchy');
require('ui/node/positioning');
require('ui/node/resizing');
