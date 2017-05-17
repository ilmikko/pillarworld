#
# Handles the screen, console output, terminals, etc.
#

require 'io/console';

class Screen
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
        def cursorSet(x=0,y=0)
                # Add 1 to both x and y as the grid starts from 1,1; not 0,0.
                x=x+1;
                y=y+1;

                $stdout.write("\033[#{y};#{x}H");
        end
        def cursorLeft(amt=1)
                $stdout.write("\033[#{amt}D");
        end
        def cursorRight(amt=1)
                $stdout.write("\033[#{amt}C");
        end
        def cursorUp(amt=1)
                $stdout.write("\033[#{amt}A");
        end
        def cursorDown(amt=1)
                $stdout.write("\033[#{amt}B");
        end
        def cursorHide
                $stdout.write("\033[?25l");
        end
        def cursorShow
                $stdout.write("\033[?25h");
        end

        def sceneSet(scene)
                @scene=scene;
        end

        # --------------------------- SCREEN COMMANDS---------------------------
        def render
                if (!@scene)
                        $console.warn("render() with no scene!");
                        return
                end

                if @renderstate==2
                        return
                end

                begin
                        @scene.call(self.width,self.height);
                rescue StandardError => e
                        $console.error("RENDER: ERROR #{e}");
                end
                @renderstate=1;
        end
        def clear(force=false)
                if (force)
                        $stdout.write("\033c");
                        self.cursorHide();
                        #$stdout.write("\033[2J");
                end
                @currentframe={};
        end
        def resize
                if @renderstate>0;
                        return
                end

                @dimensions=$stdin.winsize;

                $console.dump("Resizing to #{@dimensions}");

                @lastframe={};
                @currentframe={};
                $console.dump("Resizing done");
        end

        # ---------------------------- TEXT COMMANDS----------------------------
        def write(x,y,str,align:0)
                if (align==1||align=="center")
                        x-=str.length/2;
                elsif (align==2||align=="right")
                        x-=str.length-1;
                end

                self.put(x,y,str);
        end
        def writeLines(x,y,lines,align:0)
                len=lines.length-1;
                lines.each_with_index{|l,i|
                        self.write(x,y-len+i,l,align:align);
                }
        end

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

        def drawDebugInfo(x=0,y=0)
                self.cursorSet(x,y);
                $stdout.write("Canvas Debug Info: FPS: #{@fps} Draws (virt): #{@drawsv} Draws (real): #{@drawsa} Draws (clrd): #{@drawsc}                ");
                @drawsv=0;
                @drawsa=0;
                @drawsc=0;
        end

        # -------------------------- GRAPHICS COMMANDS--------------------------
        #def put(x,y,char)
        #        self.cursorSet(x,y);
        #        $stdout.write(char);
        #end

        def put(x,y,string)

                w=self.width;
                h=self.height;

                x+=1;
                y+=1;

                if (w<x)
                        x=w;
                end

                if (h<y)
                        y=h;
                end

                #self.cursorSet(x,y);
                #$stdout.write(string);

                pixelid=x+y*(w+1);
                string=string.split("");

                max=[string.length-1,w-x].min;

                for g in 0..max
                        @drawsv+=1;
                        @currentframe[pixelid+g]=string[g];
                end
        end

        # ----------------------------- CLASS INITS-----------------------------
        def initialize(fps:60)

                # Render State:
                # 0: ready for action
                # 1: render request
                # 2: render request taken
                # 3: new render in queue

                @renderstate=0;

                # Debug stuff
                @fps=nil;
                @drawsv=0;
                @drawsa=0;
                @drawsc=0;

                self.cursorHide();
                self.resize();
                self.clear(true);

                # Frame caching to render faster!
                # Get dem fps
                @currentframe={};
                @lastframe={};

                $console.log("Start rendering thread");
                # New thread for frame rendering and resizing check
                resizethr = Thread.new {
                        while true
                                # Resize check, every n frames
                                if ($stdin.winsize!=@dimensions)
                                        $console.debug("Window dimensions changed");
                                        self.resize();
                                        self.clear(true);
                                end

                                self.render(); # expensive

                                self.drawDebugInfo();

                                if (@renderstate==1)
                                        @renderstate=2;

                                        # New frame render
                                        width=self.width+1;

                                        @lastframe.each do |id,char|
                                                if (!@currentframe.key?(id))
                                                        y=(id/width).floor.to_i;
                                                        x=(id-y*width).to_i;

                                                        @drawsc+=1;

                                                        $stdout.write("\033[#{y};#{x}H");
                                                        $stdout.write(" ");
                                                end
                                        end

                                        #$console.dump("Rendering #{currentframe}...");
                                        @currentframe.each do |id,char|
                                                if @currentframe[id]!=@lastframe[id]
                                                        y=(id/width).floor.to_i;
                                                        x=(id-y*width).to_i;

                                                        @drawsa+=1;

                                                        $stdout.write("\033[#{y};#{x}H");
                                                        $stdout.write(char);
                                                end
                                        end
                                        @lastframe=@currentframe.clone;

                                        @renderstate=0;
                                end


                                # Everyone needs some rest
                                Kernel::sleep(1.0/fps);
                        end
                }
        end
        def close
                $console.log("Gracefully closing window");
                self.clear(true);
                self.cursorSet(0,0);
                self.cursorShow();
        end
end

$screen=Screen.new;
