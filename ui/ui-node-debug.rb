class UINode
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	@@debug=false;
	def redraw()
		col=@@debugcolors.sample;
		if @write.nil?
			text=self.class;
			# Generate a thing to write
			canvas.write(*@xy,"<#{text}",color:"\e[#{col}m");
			canvas.write(*[@xy[0]+@wh[0]-1-"#{text}".length,@xy[1]+@wh[1]-1],"#{text}>",color:"\e[#{col}m");
		elsif !canvas.nil?
			canvas.write(*@xy,@write,color:"\e[#{col}m");
		end
	end
end
