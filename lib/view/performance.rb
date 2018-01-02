class View::Performance < View
	def scene=(*)
		super;
		rethread;
	end

	def redraw
		super;
		# We call the actual redraw function after calling the scene
		_redraw;
	end

	def set(**sets)
		state=Screen::State.new(**sets);
		@current_state=state.to_s;
		@state_cache[@current_state]={} if !@state_cache.key? @current_state;
	end

	def put(x,y,char,**sets)
		set(**sets) if sets;

		current=@state_cache[@current_state];

		x,y=_round(x,y);

		# Prevent writing outside of the view
		# TODO: This might increase performance / memory a bit,
		# or it might not. Check it out later.
		return false if _outside?(x,y);

		# TODO: Port these to cache as well.
		# Return if this write request has already been done
		return if current.key?(x) && current[x][y]==char;

		# Save the write request into the 2D tree
		current[x]={} if !current.key? x;
		current[x][y]=char;
	end

	def rethread
		# Kill old threads
		@thread.kill if !@thread.nil?;
		$console.log("Rethreading #{self}");
		if @fps>0
			@thread=Thread.new{
				loop{
					redraw;
					sleep(1/@fps);
				}
			}
		end
	end

	#######
	private
	#######
	
	def _redraw
		# Real redraw from cache

		@state_cache.dup.each{|state,so|
			$console.log("New state: #{state}");
			print(state);
			so.dup.each{|x,v|
				v.dup.each{|y,char|
					next if char.nil?;
					_put(x,y,char);
				}
			}
		}

		@state_cache={};
	end

	def initialize(*args,fps:-1,**_)
		@fps=fps.to_f;

		@current_state=nil;
		@state_cache={};

		super(*args,**_);
	end
end
