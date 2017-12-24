class UI::Node
	@@canvas=nil;

	def own(parent);
		@parent=parent;
	end

	def parent;@parent;end
end
