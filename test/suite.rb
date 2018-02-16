# 
#	A simple testing suite to test everything at once.
#

require_relative('ui');

class Suite
	class Test
		def Test.create(pr)
			if pr.is_a? Proc
				return Test.new(pr);
			elsif pr.is_a? String
				return Test::File.new(pr);
			else
				raise "Cannot create a test with class #{pr.class}";
			end
		end
		@@id=0;
		def to_s
			"<Test ##{@id}>"
		end
		def run
			@proc.();
		end
		def initialize(pr)
			@proc=pr;
			@id=(@@id+=1);
		end
	end
	class Test::File < Test
		def run
			load(@proc); # treat proc as src
		end
	end

	class Status
		def redraw;
			$stdout.print("\e[H\e[K\e[m#{@msg}\e[2H");
		end
		def msg(msg)
			$console.log("S: #{msg.gsub(/\e\[[0-9;]+m/,'')}");
			@msg=msg;
			redraw;
		end
		def final(s,f,t)
			failures="#{f} failure";
			failures+='s' if f!=1;
			failures="\e[31m#{failures}\e[m" if f>0;

			successes="#{s}/#{t} succeeded";
			successes="\e[32m#{successes}\e[m" if s==t;
			successes="\e[33m#{successes}\e[m" if s<t;

			tests="Tests complete";
			tests="\e[32m#{tests}\e[m" if s==t;

			msg("#{tests} (#{failures}, #{successes})!");
		end
		def initialize(width,x:0,y:0)
			@w=width;
			@msg='';
		end
	end

	def reset;
		print("\e[2J");
	end

	def queue(test)
		@total+=1;
		@test_queue << Suite::Test.create(test);
	end

	def test(*tests)
		@status.msg("Queuing #{tests.length} test(s)...");
		tests.each{|test|
			queue(test);
		}
	end

	def run_test(test)
		reset;
		@status.msg("Running test #{test}");
		begin
			test.run;
			@successes+=1;
		rescue Exception => e
			@failures+=1;
			@status.msg("Test #{test} \e[31mFAILED: #{e}\e[m");
			sleep 2;
		end
	end

	def initialize
		@test_queue=[];

		UI.view=@view=View.new(y:1);

		@status=Suite::Status.new(@view.w);

		@current=0;
		@failures=0;
		@successes=0;
		@total=0;

		@view.on('resize',->{
			@status.redraw;
		})

		$console.log("Creating a testing thread...");
		Thread.new{
			# Wait initially for a moment
			@status.msg("Initializing...");
			sleep 0.5;
			loop{
				if @test_queue.length>0
					@current+=1;
					run_test(@test_queue.shift);
					sleep 0.5;
				else
					@status.final(@successes,@failures,@total);
					#@status.msg("Waiting for tests...");
					sleep 2;
				end
				sleep 0.5;
			}
		}
	end
end

suite=Suite.new;

Dir[__dir__+'/suite/*'].each{|file|
	suite.test(file);
};

sleep; # Keep main thread alive
