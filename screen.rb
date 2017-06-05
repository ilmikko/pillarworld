#
# Handles the screen, console output, terminals, etc.
#

require 'io/console';
require('./console.rb');

class Screen
        def width
                @dimensions[1]
        end
        def height
                @dimensions[0]
        end
        def dimensions
                [@dimensions[1]-1,@dimensions[0]-1] # Swapped from h,w to w,h for convenience
        end

        # --------------------------- CURSOR COMMANDS---------------------------
        def cursorSet(x=0,y=0)
                # Add 1 to both x and y as the grid starts from 1,1; not 0,0.
                x=x+1;
                y=y+1;

                $stdout.write("\033[#{y};#{x}H");
        end
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
                $console.dump("Resizing to #{@dimensions}");
                @dimensions=$stdin.winsize;
                $console.dump("Resizing done");
        end

        def fg;@fg;end
        def fg=(v);$stdout.write(v);end
        def bg;@bg;end
        def bg=(v);@bg=v;end

        #def writeCentered(str)
        #        len=str.length/2;
        #        self.cursorLeft(len);
        #        $stdout.write(str);
        #end
        #def writeRight(str)
        #        len=str.length-1;
        #        self.cursorLeft(len);
        #        $stdout.write(str);
        #end

        # -------------------------- GRAPHICS COMMANDS--------------------------
        #def put(x,y,char)
        #        self.cursorSet(x,y);
        #        $stdout.write(char);
        #end

        def put(x,y,char)
                $stdout.write("\033[" << y.to_s << ';' << x.to_s << 'H' << char);
        end

        def initialize()
                self.cursorHide();

                @dimensions=0,0;

                $console.log('Start resizing thread');
                # New thread for resizing check
                resizethr = Thread.new{
                        while true
                                # Resize check, every n frames
                                if ($stdin.winsize!=@dimensions)
                                        $console.debug('Window dimensions changed');
                                        self.resize();
                                        self.clear();
                                end

                                # Everyone needs some rest
                                Kernel::sleep(1.0/5.0);
                        end
                }
        end
        def close
                $console.log("Gracefully closing window");
                self.clear();
                self.cursorSet(0,0);
                self.cursorShow();
        end
end

$screen=Screen.new;
