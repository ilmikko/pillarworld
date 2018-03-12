#
# UI Wrap tells its children to use the least amount of space possible, effectively "wrapping" their children. However, I'm not sure if this should be something that every element has
#
class UI::Wrap < UI::Border
	def change
		@children.first.change_wh=@wh;
		@children.first.change_xy=[@xy[0]+@padding,@xy[1]+@padding];
		@children.first.change;
		@wh=[@children.first.w+@padding*2,@children.first.h+@padding*2];
	end
end
