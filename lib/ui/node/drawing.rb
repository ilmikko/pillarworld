class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw
		return if @@screen.nil?;
		if UI.debug?
			col=@@debugcolors.sample;
			if @write.nil?
				@@screen.bounds(*@xy,*@wh,self.class.to_s);
			end
		end

		if !@write.nil?
			#@@screen.use(@state) if @state;
			@@screen.write(*@xy,@write);
		end
	end
end
