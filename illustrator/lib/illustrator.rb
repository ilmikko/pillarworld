require('illustration');
require('input');

class Illustrator
	def load(name)
		ill=Illustration.load("demo/#{name}.ifl");
		@ui.load(ill);
	end
	def resize(w,h)
		@ui.resize(w,h);
		@cursor.resize(w,h);
	end
	def initialize()
		@cursor=Cursor.new;
		@ui=Illustrator::UI.new(@cursor);

		@input=$input;
		
		# base inputs
		@input.listen({
			"\e[A":->{
				@cursor.moveY(-1);
				@ui.redraw;
			},
			"\e[B":->{
				@cursor.moveY(1);
				@ui.redraw;
			},
			"\e[C":->{
				@cursor.moveX(1);
				@ui.redraw;
			},
			"\e[D":->{
				@cursor.moveX(-1);
				@ui.redraw;
			}
		});
	end
end

require('illustrator/ui');
