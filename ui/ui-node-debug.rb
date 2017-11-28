class UINode
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	@@debug=false;
	def redraw(write=@write)
		col=@@debugcolors.sample;
		if write.nil?
			# Generate a thing to write
			canvas.write(*@xy,'<',color:"\e[#{col}m");
			canvas.write(*[@xy[0]+@wh[0]-1,@xy[1]+@wh[1]-1],'>',color:"\e[#{col}m");
		elsif !@canvas.nil?
			canvas.write(*@xy,write,color:"\e[#{col}m");
		end
	end
end
