module Tool
	module Positionable
		attr_reader :x,:y
		def x=(v);@x=v;change_xy;end
		def y=(v);@y=v;change_xy;end

		def xy;[@x,@y];end
		def xy=(xy);@x,@y=xy;change_xy;end

		#########
		protected
		#########

		def change_xy;
			$console.log("#{self} change_xy");
			#clear;
			#redraw;
		end
	end
end
