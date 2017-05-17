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

$colors={
        default:"\x1b[0m",
        lightgreen:"\x1b[92m",
        lightyellow:"\x1b[93m",
        red:"\x1b[31m",
        green:"\x1b[32m",
        yellow:"\x1b[33m",
        blue:"\x1b[36m",
        magenta:"\x1b[35m",
        blink:"\x1b[5m",
        cyan:"\x1b[46m",
        gray:"\x1b[2m",
        darkgray:"\x1b[90m",
        bgdarkgray:"\x1b[100m"
};

class Console < BasicObject
	# How different types are formatted. String substitution is used.
	@@formats={
		"log":"[Log]%s",
		"debug":$colors[:blue]+"[Dbg]%s"+$colors[:default],
		"error":$colors[:red]+"[ERR]%s"+$colors[:default],
		"warn":$colors[:yellow]+"[WRN]%s"+$colors[:default],
		"info":$colors[:green]+"[Inf]%s"+$colors[:default],
		"dump":$colors[:darkgray]+"[dmp]%s"+$colors[:default]
	};

	# How different types are leveled, more important types have larger levels
	@@levels={
		"error":100,
		"warn":10,
		"info":-10,
		"log":-20,
		"debug":-50,
		"verbose":-75,
		"dump":-100
	};

        def file;@file;end
        def file=(v);@file=v;end
        def echo;@echo;end
        def echo=(v);@echo=v;end

        def lines
                @lines
        end

	def level
		@level
	end
	def level=(level)
		@level=level
	end

	def initialize(level=0)
		@formats=@@formats;
		@levels=@@levels;

                @echo=false;
                @file=false;

		# Which level we are on (log levels below this are not displayed)
		@level=level;

                # To hold the console lines
                @lines=[];

                # To hold message ids
                @msg=0;
	end

	# Catch-all for all methods that don't exist
	# These get printed out nevertheless, accessed method name is the type
	def method_missing(type, *args, &block)
		# If log level is not sufficient, we shall not log at all
                @msg+=1;

		if @levels[type].to_i<@level then return; end

                # global formatting
                idstamp="[#{@msg}]";
                args[0]=idstamp+"%s" % args[0];

		# If formatting for this type, format
		if @formats.key? type.to_sym
			args[0]=@formats[type] % args[0];
		end


		# Output our string (currently via puts)
                if @echo
                        $stdout.write(*args);
                        $stdout.write("\r\n");
                end
                @lines.push(*args);
	end
end

$console=Console.new(-500);
$console.log("Console initialized");

at_exit do
        if ($console.file&&$console.lines.length>0)
                $console.log("Writing to log file, bye.");
                File.write("logdumps/"+File.basename($PROGRAM_NAME)+"-#{Time.now}.log",$console.lines.join("\n"));
        end
end
