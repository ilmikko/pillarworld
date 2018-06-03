# 
# UI::Array
# Contains 0 or more UI elements, by default merely acts as a fork.
# Inherited mostly to create more complex behavior (see UI::Split for example)
#
class UI::Array < UI::Node
	def append(*items)
		items.each{ |c|
			c.own(self);
			@children.push(c);
		}

		self;
	end

	def content_width
		@wh[0];
	end

	def content_height
		@wh[1];
	end

	def empty
		$console.debug("Emptying #{self}");
		@children.clear;
	end

	def change
		@children.each{ |c|
			c.change_xy=@xy;
			c.change_wh=@wh;
			c.change;
		}
	end

	def redraw
		super;

		$console.log("Redrawing #{self} and its' #{@children.length} children...");
		@children.each{ |c|
			c.redraw;
		}
	end

	def initialize(**_)
		super(**_);

		@children=[];
	end
end
