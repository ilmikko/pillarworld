class UI::Node
	attr_reader :parent

	@@screen=nil;

	def own(parent);
		@parent=parent;
	end
end
