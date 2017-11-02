#
# A simple console for our program with different logging levels
# and the possibility of being more/less verbose.
#
# Usage:
#
# 	You need to first create a new instance of the Console class
#
#	console = Console.new;
#
#	You can now use all of the methods you want
#	console.log("hello");
#	console.tell("hello");
#	console.shout("hello");
#	console.adviosajvdasiodvjasiodjvsa("hello");
#
#	All of these are valid even if they're not defined.
#	You can then set the types here individually.
#	For example, if you call console.log, you're logging with type "log".
#	If you have a format {"log":"LOG: %s"}, your output will be:
#	"LOG: %s" % "hello"
#	> "LOG: hello"
#
#

class Console
	# How different types are formatted. String substitution is used.
	@@formats={
                default:"  %s",
		"log":"l %s",
		"debug":"D %s",
		"error":"E %s",
		"warn":"w %s",
		"info":"i %s"
	};

	# How different types are leveled, more important types have larger levels
	@@levels={
		"error":100,
		"warn":10,
		"info":5,
		"log":1,
		"debug":-20,
		"verbose":-50
	};

        def dump=(v);@filedump=v;end
        def echo=(v);@echo=v;end

        def lines
                @lines
        end

	def loglevel
		@level
	end
	def loglevel=(level)
		@level=level
	end

	def time(id)
		@timings[id]=Time.now;
	end

	def timeEnd(id)
		return if !@timings.key?id;
		self.info("#{id}: #{(Time.now-@timings[id])*1000}ms");
	end

	def initialize(level=0)
                @echo=false;
                @filedump=true;

		@timings={};

		# Which level we are on (log levels below this are not displayed)
		@level=level;

                # To hold the console lines
                @lines=[];
	end

	# Catch-all for all methods that don't exist
	# These get printed out nevertheless, accessed method name is the type
	def method_missing(type, *args, &block)
		# If log level is not sufficient, we shall not log at all

		return if !@@levels[type].nil?&&@@levels[type]<@level;

                # global formatting
                args[0]="%s %s" % [(Time.now.to_f*1000).floor.to_s.slice(-8,8),args[0]];

		# If formatting for this type, format
		if @@formats.key? type.to_sym
			args[0]=@@formats[type] % args[0];
                else
                        args[0]=@@formats[:default] % args[0];
		end


		# Output our string (currently via puts)
                if @echo
                        $stdout.write(*args);
                        $stdout.write("\r\n");
                end
                @lines.push(*args);
	end
end

$console=Console.new(ENV['LOGLEVEL'].to_i);
$console.log("Console initialized");

at_exit do
        if ($console.dump&&$console.lines.length>0)
                $console.log("Writing to log file, bye.");
                File.write("last.log",$console.lines.join("\n"));
        end
end
