class UI::Node
	@@debugcolors=(41..47).to_a+(100..107).to_a;
	def redraw()
		return if @@screen.nil?;
		col=@@debugcolors.sample;
		if UI.debug?
			if @write.nil?
				text=self.class;
				# Generate a thing to write
				$console.debug("Write #{self}!");
				@@screen.write(*@xy,"<#{text}",color:"\e[#{col}m");
				@@screen.write(*[@xy[0]+@wh[0]-1-"#{text}".length,@xy[1]+@wh[1]-1],"#{text}>",color:"\e[#{col}m");
			else
				$console.debug("Write #{self}!");
				@@screen.write(*@xy,@write,color:"\e[#{col}m");
			end
		else
			if !@write.nil?
				$console.debug("Write #{self}!");
				@@screen.write(*@xy,@write,color:@color);
			end
		end
	end
end
