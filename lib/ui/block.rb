#
# UI::Block
# Almost like a UI::Text instead of any content.
# Can be used to create elements of fixed size.
#

class UI::Block < UI::Node
	#######
	private
	#######

	def initialize(width:1, height:1, **_)
		@content_width = width;
		@content_height = height;

		super(grow:0, width:width, height:height, **_);
	end
end
