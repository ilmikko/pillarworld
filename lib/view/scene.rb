module View::Scene
	def scene=(v)
		@scene=v;
		rethread;
	end
end
