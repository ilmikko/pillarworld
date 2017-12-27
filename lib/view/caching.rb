class View
	module Caching
		def cache(x,y)
			@cached[x]={} if @cached[x].nil?;
			@cached[x][y]=1;
		end
		def clear_cache
			@cached={};
		end
	end
end
