class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw
		return if @@screen.nil?;
		$console.log("Debug redraw");
		if UI.debug?
			col=@@debugcolors.sample;
			if @write.nil?
				text=self.class.to_s;
				# Generate a thing to write for debug
				#@@screen.write(*@xy,"<#{text}",color:"\e[#{col}m");
				@@screen.write(*@xy,"<#{text}");
				#@@screen.write(*[@xy[0]+@wh[0]-1-"#{text}".length,@xy[1]+@wh[1]-1],"#{text}>",color:"\e[#{col}m");
				@@screen.write(@xy[0]+@wh[0]-1-text.length,@xy[1]+@wh[1]-1,"#{text}>");
			else
				#@@screen.write(*@xy,@write,color:"\e[#{col}m");
				@@screen.use(@state) if @state;
				@@screen.write(*@xy,@write);
			end
		else
			if !@write.nil? && !@@screen.nil?
				$console.debug("Write (no debug)");
				@@screen.use(@state) if @state;
				@@screen.write(*@xy,@write);
			end
		end
	end
end
