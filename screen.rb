#
# Handles the screen, console output, terminals, etc.
#

require 'io/console';
require('./console.rb');
require('./tool.rb');

class Screen < Evented
        def width
                @dimensions[1]
        end
        def height
                @dimensions[0]
        end
        def dimensions
                [@dimensions[1],@dimensions[0]] # Swapped from h,w to w,h for convenience
        end

        # --------------------------- CURSOR COMMANDS---------------------------
        def cursorHide
                $stdout.write("\033[?25l");
        end
        def cursorShow
                $stdout.write("\033[?25h");
        end

        # --------------------------- SCREEN COMMANDS---------------------------
        def clear
                $stdout.write("\033c");
                self.cursorHide();
        end
        def resize
                @dimensions=$stdin.winsize;
                $console.dump("Resized to #{@dimensions}");
                self.trigger(:resize);
        end

        def fg;@fg;end
        def fg=(v);$stdout.write(v);end
        def bg;@bg;end
        def bg=(v);@bg=v;end

        # -------------------------- GRAPHICS COMMANDS--------------------------

        def put(x,y,str)
                $stdout.write("\033[" << y.to_s << ';' << x.to_s << 'H' << str.to_s);
        end

        def initialize()
                super();

                @dimensions=0,0;

                self.clear();
                self.resize();

                $console.log('Start resizing thread');
                # New thread for resizing check
                resizethr = Thread.new{
                        while true
                                # Resize check, every n frames
                                if ($stdin.winsize!=@dimensions)
                                        $console.debug('Window dimensions changed');
                                        self.clear();
                                        self.resize();
                                end

                                # Everyone needs some rest
                                Kernel::sleep(1.0/30.0);
                        end
                }
        end
        def close
                $console.log("Gracefully closing window");
                self.clear();
                self.cursorShow();
                self.trigger(:close);
        end
end

$screen=Screen.new;
