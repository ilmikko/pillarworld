require('console');
require("io/console");

# TODO: This library needs a rewrite

# A basic way to gather user input. You can just require('input') and
# then do $input.listen(
#	'key'->{
#		action();
#	}
# )

class Input
	# Multiple rules at once in the form of a dictionary, for ease of use.
	def listen(keys)
		keys.each{ |l,k|
			self.rule(l,k);
		}
	end
	def rule(key,action)
		key=key.to_sym;

		$console.debug("KEY #{key} new rule #{action}");

		if @rules.key? key
			rule=@rules[key];

			# TODO: Why would this ever happen? Rule is supposed to be an array.
			if (rule.respond_to? :call)
				@rules[key]=rule=[rule];
			end

			rule.push(action);
		else
			@rules[key]=[action];
		end
	end
	def initialize
		# Exit function, because we override CTRL-C. q is also mapped to exit for now.
		x = ->{
			# If we are run by the main program, close it, otherwise just do an exit.
			if $main
				$main.close('user signal');
			else
				exit;
			end
		};

		@rules={
			"\u0003":x,
			'q':x
		};

		# No echo to output
		STDIN.echo = false;
		STDIN.raw!

		Thread.new{
			# Keypress check
			while true
				char = STDIN.getch;

				# Escape characters
				if (char=="\u001b")
					$console.debug("Escaped, 2 more");
					char+=STDIN.getch+STDIN.getch;
				end

				$console.debug("Input: [#{char}](#{char.ord})");

				key=char;

				begin
					key=key.to_sym;
					if @rules.key? key
						$console.debug("Input: #{char} exists in rules");
						rule=@rules[key];

						# Check if rule is iterable
						if (rule.respond_to? :each)
							rule.each{ |f|
								f.call();
							}
							# Check if it's callable
						elsif (rule.respond_to? :call)
							rule.call();
						else
							$console.error("Cannot parse rule for key #{key}! (#{rule})");
						end
					end
				rescue StandardError => e
					$console.error("INPUT: ERROR: #{e}");
					$console.error(e.backtrace); # extremely useful
					# we don't reraise because the input thread can't crash in case the listener has an error
				end
			end
		}
	end

	def close
		# Remember to set these back to their default values on close.
		STDIN.echo = true;
		STDIN.cooked!
	end
end

$input=Input.new();

at_exit{
	# Remember to close gracefully.
	$input.close();
}
