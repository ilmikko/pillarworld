#
# UI::Layer, contains items in a layered fashion.
# A bit like UI::Array except calculates content size correctly.
# Why not use UI::Array then? Because it's supposed to be an abstract
#

class UI::Layer < UI::Array
	def content_width
		# As the content is layered on top of each other, our content width will be the maximum width of a child.
		@children.reduce(0){ |max,child|
			child.content_width > max ? child.content_width : max;
		};
	end

	def content_height
		@children.reduce(0){ |max,child|
			child.content_height > max ? child.content_height : max;
		};
	end
end
