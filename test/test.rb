# 
#	A simple testing suite to test everything at once.
#

$LOAD_PATH << (__dir__<<'/../lib');
require 'ui';

class Suite
	class Progress
		class Queue
			def to_s
				"[" << @tests.reduce(''){|a,b|a<<b.to_s} << "]";
			end

			def failures
				@tests.reduce(0){|a,b| (!b.is_a? Queue) ? (b.status==:failure ? a+1 : a) : (a+b.failures)};
			end

			def successes
				@tests.reduce(0){|a,b| (!b.is_a? Queue) ? (b.status==:success ? a+1 : a) : (a+b.successes)};
			end

			def total
				@tests.reduce(0){|a,b| (!b.is_a? Queue) ? (a+1) : (a+b.total)};
			end

			def push(*items)
				@tests.push(*items);
			end

			attr_reader :status;

			private

			def initialize(tests=[])
				@status=:nothing;
				@tests=tests;
			end
		end

		def failures
			@queue.failures;
		end

		def successes
			@queue.successes;
		end

		def total
			@queue.total;
		end

		def to_s
			@queue.to_s;
		end

		def queue(test)
			@queue.push(test);
		end

		def queue_bunch(tests)
			@queue.push(Queue.new(tests));
		end

		private

		def initialize
			@queue=Queue.new;
		end
	end

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

		@@test_symbols={
			nothing: '.',
			running: ':',
			success: '+',
			failure: '!'
		};
		@@id=0;

		def to_s
			@@test_symbols[@status]||'?';
		end
		
		def run_test
			@proc.();
		end

		def run_start
				@status=:running;
		end

		def run
			begin
				run_test;
				@status=:success;
			rescue Exception => e
				@status=:failure;
				raise e;
			end
		end

		attr_reader :status;

		private

		def initialize(pr)
			@status=:nothing;
			@proc=pr;
			@id=(@@id+=1);
		end
	end
	class Test::File < Test
		def run_test
			load(@proc); # treat proc as src
		end
	end

	class Status
		def redraw;
			# Clearing
			$stdout.print("\e[H\e[K\e[m");
			right=@progress.to_s;
			len = right.length;

			# Very hackish colors
			right=right.gsub(/:/,"\e[33m:\e[m");
			right=right.gsub(/!/,"\e[31m!\e[m");
			right=right.gsub(/\+/,"\e[32m+\e[m");

			$stdout.print("\e[;#{Screen.width-len+1}H#{right}"); # Right side
			$stdout.print("\e[;H#{@msg}\e[2H"); # Left side
		end
		def msg(msg)
			$console.log("S: #{msg.gsub(/\e\[[0-9;]+m/,'')}");
			@msg=msg;
			redraw;
		end
		def final(progress)
			# Calculate failures and successes
			
			f=progress.failures;
			s=progress.successes;
			t=progress.total;

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

		private

		def initialize(progress,x:0,y:0)
			@msg='';
			@progress=progress;
		end
	end

	def reset;
		print("\e[2J");
		@status.redraw;
	end

	def queue(test)
		@test_queue << test;
	end

	def queue_directory(dir)
		$console.log("Queuing #{dir}...");
		Dir[dir].sort.each{|file|
			if File.directory? file
				# Directory, queue a bit differently
				test(*Dir[file<<'/*'].sort);
			else
				test(file);
			end
		};
	end

	def test(*tests)
		tests.map!{|test| Suite::Test.create(test)}

		if tests.length==1
			test=tests.first;

			@progress.queue(test);
			queue(test);
		else
			@status.msg("Queuing #{tests.length} test(s)...");

			@progress.queue_bunch(tests);
			tests.each{|test|
				queue(test);
			}
		end
	end

	def run_test(test)
		reset;

		begin
			test.run_start;
			@status.msg("Running test #{test} (#{@test_queue.length})");
			test.run;
			sleep 1;
		rescue Exception => e
			@status.msg("Test #{test} \e[31mFAILED: #{e}\e[m");
			sleep 2;
		end

		reset;
	end

	def initialize
		@test_queue=[];

		UI.view=@view=View.new(y:1);

		@progress=Suite::Progress.new();
		@status=Suite::Status.new(@progress);

		@view.on('resize',->{
			@status.redraw;
		})

		$console.log("Creating a testing thread...");
		Thread.new{
			# Wait initially for a moment
			@status.msg("Initializing...");
			sleep 0.2;
			loop{
				if @test_queue.length>0
					run_test(@test_queue.shift);
				else
					@status.final(@progress);
					#@status.msg("Waiting for tests...");
					sleep 2;
				end
				sleep 0.1;
			}
		}
	end
end

suite=Suite.new;

if ARGV.length==0
	# Test all
	suite.queue_directory(__dir__<<'/test/*');
else
	dir=ARGV[0];
	suite.queue_directory(__dir__<<"/test/**/*#{dir}*");
end

sleep; # Keep main thread alive
