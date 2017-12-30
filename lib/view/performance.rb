class View::Performance < View
	def scene=(*)
		super;
		rethread;
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

	def set(**sets)
		
	end

	#######
	private
	#######

	def initialize(*args,fps:-1,**_)
		super(*args,**_);

		@fps=fps.to_f;
	end
end
