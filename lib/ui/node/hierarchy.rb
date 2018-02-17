class UI::Node
	attr_reader :parent

	@@view=nil;

	def own(parent);
		@parent=parent;
	end
end
