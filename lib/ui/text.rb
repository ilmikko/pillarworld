#
# UIText
# Contains a short string of text. Always has a height of 1.
#
class UI::Text < UI::Node
	attr_reader :length, :text

	def text=(v);
		@text=v;
		@length=v.length;

		# We can know the size of this element by the length of the text
		# UIText never spans multiple lines
		self.max_width=@length;
		self.max_height=1;

		$console.log("#{self} resized to #{@wh} (#{[@length,1]})");
		change;
	end

	def change
		# See if we have to crop our text.
		# FIXME: currently only crop on the right.
		# I.e. we assume left text align.
		
		if @wh[1]<1
			# No space to write anything.
			$console.log("No space to write anything #{@wh}");
			@write='';
			return;
		end

		@write=@text;
		if @write.length>@wh[0]
			@write=@write[0..-1-(@write.length-@wh[0])];
		end
	end

	def redraw
		$console.log("Text redrawing (write:#{@write})...");
		super;
	end

	def initialize(text='',**_)
		super(**_);

		self.text=text;
	end
end
