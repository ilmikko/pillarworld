class View::Performance < View
	include View::Caching
	def scene=(*)
		super;
		rethread;
	end
	def put(x,y,char,color: nil)
		# Cache optimizations - we don't need to clear the whole screen
		# (and in fact, a single View should never clear a whole Screen)
		#
		# Return if we have this particular one already cached
		# return if cached?(x,y); (TODO: This is still buggy as we need to check color as well)
		
		# We need these for caching
		x=x.round.to_i if !x.is_a? Integer;
		y=y.round.to_i if !x.is_a? Integer;

		return false if !super(x,y,char,color:color);
		
		# Cache the current character and color to be put on screen
		# FIXME: Currently only saving write positions.
		# TODO: What about \e[7m, bold and so on?
		cache(x,y);
	end

	def clear
		# TODO: Clearing optimizations
		@cached.dup.each{|x,v|
			v.dup.each{|y,v|
				erase(x,y);
			}
		}
		clear_cache;
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
	def initialize(*args,fps:-1,**_)
		super(*args,**_);

		@fps=fps.to_f;
		@cached={};
	end
end
