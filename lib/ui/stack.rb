# 
# UI::Stack
# An opposer to UI::Split - where Split tries to use all the space as it can, Stack tries to stack as many child elements next to each other as it can.
#

class UI::Stack < UI::Array
	def content_width
		if @direction==:row
			# sum of all the widths
			@children.reduce(0){|sum,x| sum+x.width;};
		else
			# just maximum width
			super
		end
	end
	
	def content_height
		if @direction==:row
			# just maximum height
			super
		else
			# sum of all the heights
			@children.reduce(0){|sum,x| sum+x.height;};
		end
	end

	def full?
		if @direction==:row
			ret = content_width >= @wh[0];
		else
			ret = content_height >= @wh[1];
		end

		$console.log("Is stack full? #{ret} #{content_width} >= #{@wh[0]}");

		return ret;
	end

	def change
		w,h=@wh;
		x,y=@xy;

		# As said before, we want to identify the widths and heights before the positions.

		# TODO: all of these can be improved, as there is a lot of repetition
		if @direction==:row
			size_available = w;
		else
			size_available = h;
		end

		# A child can be:
		# width_grower (use available space)
		# 	-> with width_min (don't go below this width, ever)
		# 	-> with width_max (grow only so large)
		# width_shrinker (use only space we need)
		# 	-> with width_min (this is the min space we need, regardless of children)
		# 	-> with width_max (never go above this width)

		growers = [];
		@children.each{ |child|

			# Check if child is a grower or not
			if child.grow > 0
				growers << child;
			else
				content_size=@wh;

				if @direction==:row
					content_width = child.content_width;
					content_size[0] = content_width;
					size_available -= content_width;
				else
					content_height = child.content_height;
					content_size[1] = content_height;
					size_available -= content_height;
				end

				child.change_wh = content_size;
			end
		}

		# If we have available size, allow our growers to use that space
		if size_available>0 and growers.count>0
			grow_sum = growers.reduce(0){ |sum, child| sum+child.grow };
			
			growers.each{|child|
				portion = child.grow.to_f / grow_sum;

				child_size = @wh;
				if @direction==:row
					child_size[0] = portion*size_available;
				else
					child_size[1] = portion*size_available;
				end

				child.change_wh = child_size;
				child.change;
			}
		end

		# Calc positions
		if @direction==:row
			offset = x;
		else
			offset = y;
		end

		@children.each{|child|
			child_pos = [x,y];

			if @direction==:row
				child_pos[0] = offset;
				offset+=child.width;
			else
				child_pos[1] = offset;
				offset+=child.height;
			end

			child.change_xy = child_pos;
			child.change;
		}
	end

	def initialize(direction: :col,**_)
		super(**_);

		@direction=direction;
	end
end
