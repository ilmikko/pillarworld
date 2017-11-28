#
# UIText
# Contains a short string of text. Always has a height of 1.
#
class UIText < UINode
	def length;@length;end

	def text;@text;end
	def text=(v);
		@write=v;
		@length=v.length;
		# We can know the size of this element by the length of the text
		# UIText never spans multiple lines
		@preferredwh=[@length,1];
		self.wh=[@length,1];
		self.change;
	end

	def initialize(text='',color: nil,**_)
		super(**_);

		@wh=[0,0];
		@preferredwh=[0,0];

		self.color=color;
		self.text=text;
	end
end
