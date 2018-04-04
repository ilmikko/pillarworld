# 
# UIAlign
# Aligns UI elements horizontally and/or vertically.
#
# Usage:
# UIAlign.new(horizontalalign: :center, verticalalign: :center).append(...)
#
class UI::Align < UI::Pass
	@@verticalaligns={
		top:0,
		center:0.5,
		bottom:1
	}
	@@horizontalaligns={
		left:0,
		center:0.5,
		right:1
	}

	def verticalalign;
		@@verticalaligns.key(@verticalalign);
	end
	def verticalalign=(v);
		raise "Unknown vertical align: #{v}" if !@@verticalaligns.key?v;
		@verticalalign=@@verticalaligns[v];
	end

	def horizontalalign;
		@@horizontalaligns.key(@horizontalalign);
	end
	def horizontalalign=(v);
		raise "Unknown horizontal align: #{v}" if !@@horizontalaligns.key?v;
		@horizontalalign=@@horizontalaligns[v];
	end

	def change;
		w,h=@wh;
		x,y=@xy;

		@children.each{ |child|
			child.change_wh=@wh;
			child.change;
			# calc aligns, position
			cw,ch=child.content_size;

			$console.log("Child size: #{[cw,ch]}");

			ha=(w-cw)*@horizontalalign;
			va=(h-ch)*@verticalalign;

			child.change_xy=[x+ha,y+va];
			child.change;
		}
	end

	def initialize(ha: nil, va: nil, horizontalalign: :center, verticalalign: :center,**_)
		super(**_);

		self.horizontalalign=ha||horizontalalign;
		self.verticalalign=va||verticalalign;
	end
end
