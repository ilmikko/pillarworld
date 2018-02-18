module Tool
	module Evented
		def fire(name)
			return if @events.nil?;
			return if !@events.key?(name);
			@events[name].each{ |f| f.() if !f.nil?; };
		end
		def on(name,callback)
			@events={} if @events.nil?;
			@events[name]=[] if @events[name].nil?;
			@events[name] << callback;
			return [name,callback];
		end
		def off(id)
			name,callback=id;
			return if @events.nil?;
			return if !@events.key?(name);
			@events[name].delete(callback);
		end
	end
end
