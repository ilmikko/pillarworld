class Input
        def listen(p)
                @listeners.push(p);
        end
        def initialize
                @listeners=[];

                Thread.new {
                        # Keypress check

                        STDIN.echo = false;

                        while true

                                char = STDIN.getch;

                                if (char=="\u0003"||char=="q")
                                        $console.log("Terminating program (user signal)");
                                        $screen.close();
                                        exit(1);
                                end

                                begin
                                        @listeners.each do |l|
                                                break if l.call(char)
                                        end
                                rescue StandardError => e
                                        $console.error("INPUT: ERROR #{e}");
                                end
                        end
                }
        end
end

$input=Input.new();
