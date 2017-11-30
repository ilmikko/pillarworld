class UITextLine < UIArray
	def append(*items)
		super(*items.map{|item|
			if !item.is_a? UINode
				# Convert strings to UIText by their words.
				if item.is_a? String
					item.split(/(\s+)/).map{|word| UIText.new(word)}
				else
					raise "Error: Cannot append #{item.class} into #{self.class}";
				end
			end
		}.flatten)
	end

	def change
		x,y=@xy;
		offset=0;
		@children.each{|c|
			c.xy=[x+offset,y];
			offset+=c.w;
			c.change;
		}
	end

	def initialize(words='')
		super();
		append(words);
	end
end
