#
# UIText
# Contains a short string of text. Always has a height of 1.
#
class UI::Text < UI::Node
	def length;@length;end

	def text;@text;end
	def text=(v);
		@text=v;
		@length=v.length;

		# We can know the size of this element by the length of the text
		# UIText never spans multiple lines
		@preferredwh=[@length,1];
		self.wh=@preferredwh;
		change;
	end

	def change
		# See if we have to crop our text.
		# FIXME: currently only crop on the right.
		# I.e. we assume left text align.
		
		if @wh[1]<1
			# No space to write anything.
			@write='';
			return;
		end

		@write=@text;
		if @write.length>@wh[0]
			@write=@write[0..-1-(@write.length-@wh[0])];
		end
	end

	def initialize(text='',color: nil,**_)
		super(**_);

		@preferredwh=[0,0];

		self.color=color;
		self.text=text;
	end
end
