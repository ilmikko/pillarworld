# 
# UINode
# Contains public functions every element should have.
# Every UI element inherits UINode.
#

class UI::Node
	attr_accessor :id;
	attr_reader :grow;

	# TODO: Rename this to 'changed' or alternatively make it an event.
	def change;end # Hook for when something has changed

	def initialize(id: nil, width: nil, height: nil, grow: 1, **sets)
		@id=id;
		@xy=[0,0];

		# Size and resizing
		@wh=[0,0];
		@width_min=@width_max=@height_min=@height_max=nil;
		@content_width=@content_height=0;
		# Experimental
		@grow=grow;

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

require('ui/node/change');
require('ui/node/resizing');
require('ui/node/drawing');
require('ui/node/hierarchy');
require('ui/node/positioning');
