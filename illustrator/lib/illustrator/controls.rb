require('input');

class Illustrator::Controls
	def initialize
		# TODO: fix the input library
		@input=$input; # Input.new
		
		# base inputs
		@input.listen({
			"\e[A":->{
				@cursor.moveY(-1);
				@view.redraw;
			},
			"\e[B":->{
				@cursor.moveY(1);
				@view.redraw;
			},
			"\e[C":->{
				@cursor.moveX(1);
				@view.redraw;
			},
			"\e[D":->{
				@cursor.moveX(-1);
				@view.redraw;
			}
		});
	end
end

require('illustrator/controls/colors');
require('illustrator/controls/characters');
require('illustrator/controls/file');
require('illustrator/controls/paint');
