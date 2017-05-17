require("io/console");

class Input
        def listen(keys)
                keys.each{ |l,k|
                        self.rule(l,k);
                }
        end
        def rule(key,action)
                key=key.to_sym;
                $console.log("KEY #{key} new rule #{action}");

                if @rules.key? key
                        rule=@rules[key];

                        if (rule.respond_to? :call)
                                @rules[key]=rule=[rule];
                        end

                        rule.push(action);
                else
                        @rules[key]=[action];
                end
        end
        def initialize

                x = ->{
                        $console.log("Terminating program (user signal)");
                        $input.close();
                        $screen.close();
                        exit(1);
                };

                @rules={
                        "\u0003":x,
                        'q':x
                        };

                STDIN.echo = false;
                STDIN.raw!

                Thread.new {
                        # Keypress check
                        while true
                                char = STDIN.getch;

                                # Escape characters
                                if (char=="\u001b")
                                        $console.debug("Escaped, 2 more");
                                        char+=STDIN.getch+STDIN.getch;
                                end

                                $console.debug("Input: [#{char}](#{char.ord})");

                                key=char; # FIXME: this is sometimes incorrect (see up/down arrows for example)

                                begin
                                        key=key.to_sym;
                                        if @rules.key? key
                                                $console.dump("Input: #{char} exists in rules");
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
                                        $console.error("INPUT: ERROR #{e}");
                                end
                        end
                }
        end

        def close
                STDIN.echo = true;
                STDIN.cooked!
        end
end

$input=Input.new();
