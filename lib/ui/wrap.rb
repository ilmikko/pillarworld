#
# UI::Wrap wraps the elements across multiple stacks when the stacks are full.
# This is something I haven't quite figure out yet, but it's basically text wrap with other elements.
# It's basically a stack of stacks.
# TODO: This sucks
# NOTE: This is optimized for text first, I need to create a general algorithm for other stuff
#
# NOTE: This is an experimental version that uses a stack of stacks.
#class UI::Wrap < UI::Array
#	def append(*nodes)
#		super(*nodes);
#
#		while nodes.size > 0
#			node = nodes.shift;
#
#			# TODO: If last stack is full, create a new stack
#			new_stack if @stacks.last.full?;
#
#			# Append the nodes to the last stack
#			@stacks.last.append(node);
#		end
#
#		self
#	end
#
#	def change
#		# Update our current stack situation
#		@stacks.each{ |stack| 
#			stack.change_wh=@wh;
#			stack.change_xy=@xy;
#			stack.change;
#		};
#
#		self
#	end
#
#	#######
#	private
#	#######
#	
#	def new_stack
#		stack = UI::Stack.new(direction: :row);
#		stack.own(self);
#
#		@stacks << stack;
#	end
#
#	def initialize
#		super;
#
#		@stacks=[];
#		new_stack;
#	end
#end
class UI::Wrap < UI::Array
	def change
		# Greedy algorithm to stack the lines most optimally
		# TODO: This doesn't have to re-run every time we resize.

		# TODO: Directions
		w,h=@wh;
		x,y=@xy;

		# Normally space in a line
		primary_space = w;

		# Normally space for lines of text
		secondary_space = h;

		@children.each{ |c|
			$console.log("Wrap: #{primary_space},#{secondary_space} vs #{[w,h]}");

			cw = c.content_width;

			if primary_space-cw <= 0
				# Ran out of primary space, use secondary space
				primary_space = w;

				secondary_space -= 1; # FIXME: This is wrong, it should be the maximum height

				# Ran out of secondary space, it's over
				break if secondary_space <= 0;
			end

			c.change_xy=[x+w-primary_space,y+h-secondary_space];
			c.change_wh=[primary_space,secondary_space];

			c.change;

			# TODO: Not just cw
			primary_space -= cw;
		}

		self
	end

	#######
	private
	#######

	def initialize
		super;
	end
end
