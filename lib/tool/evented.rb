module Tool
	module Evented
		def fire(name)
			return if @events.nil?
			return if !@events.key?(name);
			@events[name].each{|f| f.(); }
		end
		def on(name,callback)
			@events={} if @events.nil?;
			@events[name]=[] if @events[name].nil?;
			@events[name].push(callback);
		end
	end
end
