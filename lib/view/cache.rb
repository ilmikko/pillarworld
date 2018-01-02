class View::Cache
	def write(x,y)
		x=x.to_i;
		y=y.to_i;
		$console.log("Write #{x},#{y}");
		@writes["#{x},#{y}"]=true;
	end
	def each_write
		@writes.each{|key,tru|
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
