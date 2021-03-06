class UI::TextLine < UI::Array
	def append(*items)
		super(*items.map{|item|
			if !item.is_a? UI::Node
				# Convert strings to UIText by their words.
				if item.is_a? String
					item.split(/(\s+)/).map{|word| UI::Text.new(word); }
				else
					raise "Error: Cannot append #{item.class} into #{self.class}";
				end
			else
				item;
			end
		}.flatten)
	end

	def change
		x,y=@xy;
		maxw,maxh=@wh;
		widthmax=0;

		$console.log("#{maxw} #{maxh}");

		if maxh<=0
			# Height is 0, word wrap is useless.
			# Don't show the children.
			@children.each{|c|
				c.h=0;
				c.change;
			}
			return;
		elsif maxw<=0
			# Width is 0, word wrap is useless.
			# Just don't show the children.
			@children.each{|c|
				c.w=0;
				c.change;
			}
			return;
		end

		line=0;
		offset=0;
		# Fit children in maxw,maxh (word wrap)
		for i in 0...@children.length
			c=@children[i];
			if offset>=maxw or offset+c.w>=maxw
				line+=1;
				# Conveniently, offset now contains the width of the current line. Check if it is the width of our element.
				widthmax=offset if offset>widthmax;
				offset=0;
				if line>=maxh
					# No more lines in the element.
					for j in i...@children.length
						c=@children[j];
						c.h=0;
						c.change;
					end
					break;
				end
			end
			c.xy=[x+offset,y+line];
			c.wh=[maxw,1];
			c.change;
			offset+=c.w;
		end

		widthmax=offset if offset>widthmax;

		# Scale us according to our content (don't use more space than we have to)
		@wh=[widthmax,line+1];
		$console.log("Ahoy! I just set my wh to #{@wh}");
	end

	def redraw
		$console.log("Heya! I'm #{self} and I'm redrawing with #{@wh}");
		super;
	end

	def initialize(words='')
		super();
		append(words);
	end
end
