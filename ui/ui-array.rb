# 
# UIArray
# Contains 0 or more UI elements, by default merely acts as a fork.
# Inherited mostly to create more complex behavior (see UIFlex for example)
#
class UIArray < UINode
	def append(*items)
		items.each{ |c|
			c.own(self);
			@children.push(c);
		}

		self;
	end

	def empty
		@children.clear;
	end

	def change
		@children.each{ |c|
			c.xywh=[*@xy,*@wh];
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
