require('ui');
require('illustrator/ui/cursor');

# Set view w and h
#UI.debug=true;

class Illustrator::UI
	def resize(w,h)
		@cursor.resize(w,h);
		w+=2;
		h+=2;
		$console.log("ILL:Resize border to #{[w,h]}");
		@border.resize(w,h);
		redraw;
	end
	def load(illustration)
		@illustration=illustration;
		resize(*illustration.wh);
	end
	def redraw
		@ui.root.update;
		#@border.redraw;
		#@text.redraw;
		#@view.redraw;
	end
	def initialize(cursor,illustration=nil)
		@illustration=illustration;
		@cursor=cursor;

		@ui=UI.new;
		@ui.show(
			UI::Stack.new(ha: :center, va: :center, direction: :col).append(
				@border=UI::Border.new(width: 1, height: 1).append(
					@view=UI::View.new
				),
				@text=UI::Text.new('99999@255,255,255')
			)
		);

		@view.scene=->{
			return if @illustration.nil?;

			cursorpos=@cursor.xy;

			@text.text="#{@illustration.get_char(*cursorpos).ord}@#{@illustration.get_col(*cursorpos).rgb.join(',')}                    ";
			@text.redraw;

			@illustration.each_cell{|x,y,col,char|
				$console.log("#{x},#{y},#{char},#{col}");
				@view.put(x,y,char,color:col);
			}

			@view.put(*cursorpos,@illustration.get_char(*cursorpos),color:@illustration.get_col(*cursorpos),inverted:true);
		};
	end
end
