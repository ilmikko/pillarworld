class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw
		return if @@view.nil?;
		$console.log("Debug redraw");
		if UI.debug?
			col=@@debugcolors.sample;
			if @write.nil?
				text=self.class.to_s;
				# Generate a thing to write for debug
				#@@view.write(*@xy,"<#{text}",color:"\e[#{col}m");
				@@view.write(*@xy,"<#{text}");
				#@@view.write(*[@xy[0]+@wh[0]-1-"#{text}".length,@xy[1]+@wh[1]-1],"#{text}>",color:"\e[#{col}m");
				@@view.write(@xy[0]+@wh[0]-1-text.length,@xy[1]+@wh[1]-1,"#{text}>");
			else
				#@@view.write(*@xy,@write,color:"\e[#{col}m");
				@@view.use(@state) if @state;
				@@view.write(*@xy,@write);
			end
		else
			if !@write.nil? && !@@view.nil?
				$console.debug("Write (no debug)");
				@@view.use(@state) if @state;
				@@view.write(*@xy,@write);
			end
		end
	end
end
