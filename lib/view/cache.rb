class View::Cache
	def write(x,y,char)
		x=x.to_i;
		y=y.to_i;

		if char.length==1
			# no complications
			@writes["#{x},#{y}"]=true;
		else
			# split and write
			for i in x...x+char.length
				@writes["#{i},#{y}"]=true;
			end
		end
		#$console.log("Caching: #{x},#{y} => #{char.length} (#{char})");
	end
	def each_write
		@writes.dup.each{|key,tru|
			x,y=key.split(',');
			yield [x.to_i,y.to_i];
		}
	end

	def look_at_writes
		$console.log("There are #{@writes.size} writes");
	end
	def clear_writes
		$console.log("Writes cleared");
		@writes.clear;
	end
	def initialize
		@writes={};
	end
end
