class View
	module Caching
		def round_for_cache(x,y)
			x=x.round.to_i if !x.is_a? Integer;
			y=y.round.to_i if !y.is_a? Integer;
			return [x,y];
		end
		def cache(x,y)
			@cached[x]={} if @cached[x].nil?;
			@cached[x][y]=1;
		end
		def clear_cache
			@cached={};
		end
	end
end
