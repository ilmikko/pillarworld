class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw
		return if @@view.nil?;
		if UI.debug?
			col=@@debugcolors.sample;
			if @write.nil?
				@@view.bounds(*@xy,*@wh,self.class.to_s);
			end
		end

		if !@write.nil?
			#@@view.use(@state) if @state;
			@@view.write(*@xy,@write);
		end
	end
end
