# 
#	A simple testing suite to test everything at once.
#

require_relative('ui');

class Suite
	class Status
		def msg(msg)
			$stdout.print("\e[H\e[K\e[m#{msg}");
			$console.log("S: #{msg.gsub(/\e\[[0-9;]+m/,'')}");
		end
		def final(s,f,t)
			failures="#{f} failure";
			failures+='s' if f>1;
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
		end
	end

	def test(*tests)
		current=0;
		successes=0;
		failures=0;
		total=tests.length;

		@status.msg("Starting #{total} test(s)...");
		sleep 0.2;

		tests.each{|test|
			current+=1;
			@status.msg("Test ##{current}...");
			begin
				test.();
				successes+=1;
			rescue Exception => e
				failures+=1;
				@status.msg("Test #{current} \e[31mFAILED: #{e}\e[m");
			end
			sleep 1;
		};
		sleep 0.2;

		@status.final(successes,failures,total);
	end
	def initialize
		@view=View.new(y:1);
		UI.view=@view;
		@ui=UI.new;
		@status=Suite::Status.new(@view.w);
	end
end

suite=Suite.new;
	
suite.test(
	->{
		UI.new.show(
			UI::Border.new.append(
				UI::Align.new.append(
					UI::Text.new('Test #1')
				)
			)
		)
	},
	->{
		UI.new.show(
			UI::Bogus.new.append(
				UI::Align.new.apparent()
			)
		)
	},
	->{
		UI.new.show(
			UI::Align.new.append(
				UI::Border.new.append(
					UI::Text.new('Test #2')
				)
			)
		)
	}
)

sleep;
