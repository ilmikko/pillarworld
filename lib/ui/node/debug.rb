class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw()
		return if @@canvas.nil?;
		col=@@debugcolors.sample;
		if UI.debug?
			if @write.nil?
				text=self.class;
				# Generate a thing to write
				@@canvas.write(*@xy,"<#{text}",color:"\e[#{col}m");
				@@canvas.write(*[@xy[0]+@wh[0]-1-"#{text}".length,@xy[1]+@wh[1]-1],"#{text}>",color:"\e[#{col}m");
			elsif !@@canvas.nil?
				@@canvas.write(*@xy,@write,color:"\e[#{col}m");
			end
		else
			if !@write.nil? && !@@canvas.nil?
				@@canvas.write(*@xy,@write,color:@color);
			end
		end
	end
end
