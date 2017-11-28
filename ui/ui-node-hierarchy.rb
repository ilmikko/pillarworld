class UINode
	def own(parent);
		@parent=parent;
	end

	def canvas;@@canvas;end
	def canvas=(v);
		@@canvas=v;
	end

	def parent;@parent;end
end
