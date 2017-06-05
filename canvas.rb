require("./screen.rb");

class Canvas
        def x;@xyz[0]end
        def x=(v)@xyz[0]=v;end
        def y;@xyz[1]end
        def y=(v)@xyz[1]=v;end
        def z;@xyz[2]end
        def z=(v)@xyz[2]=v;end

        def zoom;@zoom;end
        def zoom=(v)@zoom=v;end

        def char;@char;end
        def char=(v);@char=v;end

        def insideCanvas?(sx,sy,w,h)
                return sx>=0&&sx<w&&sy>=0&&sy<h;
        end

        def sceneSet(scene)
                @scene=scene;
        end
        def sceneRender()
                if (!@scene)
                        $console.warn("render() with no scene!");
                        return
                end

                begin
                        @scene.call(*@screen.dimensions);
                rescue StandardError => e
                        $console.error("RENDER: ERROR #{e}");
                end
        end

        # ---------------------------- TEXT COMMANDS----------------------------
        def write(x,y,str,align:0)
                if (align==1||align=="center")
                        x-=str.length/2;
                elsif (align==2||align=="right")
                        x-=str.length-1;
                end

                self.puts(x,y,str);
        end
        def writeLines(x,y,lines,align:0)
                len=lines.length-1;
                lines.each_with_index{ |l,i|
                        self.write(x,y-len+i,l,align:align);
                }
        end

        def plot(f,centerx,centery,width,height,char: @char)
                m=@zoom;
                dw,dh=@screen.dimensions;

                sx=(centerx*m+dw/2-self.x*m).to_i;
                sy=(centery*m+dh/2-self.y*m).to_i;

                heighthalf=(height/2*m).to_i;
                widthhalf=(width/2*m).to_i;

                # The minimums and maximums are to speed up the process of drawing very large circles
                # We don't have to check areas that are outside the viewport

                begin
                        for cy in -([heighthalf,sy].min)..([heighthalf,dh-sy].min)
                                for cx in -([widthhalf,sx].min)..([widthhalf,dw-sx].min)
                                        # Plotting function
                                        if (f.call(cx,cy,self.z,m))
                                                x=sx+cx;
                                                y=sy+cy;

                                                self.put(x,y,char);
                                        end
                                end
                        end
                rescue StandardError => e
                        $console.error("PLOT: ERROR #{e}");
                end
        end

        # Different known shapes
        def drawCircle(centerx=0,centery=0,radius: 1,char: @char)
                self.plot(->(x,y,m){
                        return y*y+x*x<radius*radius*m*m;
                },centerx,centery,0,radius*2,radius*2,char:char);
        end

        def draw(x=0,y=0,char: @char)
                # Translate to screen coordinates (zoom plus center)
                m=@zoom;
                w,h=@screen.dimensions;
                sx=(x*m+w/2-self.x*m).to_i;
                sy=(y*m+h/2-self.y*m).to_i;

                if (insideCanvas? sx,sy,w,h)
                        self.put(sx,sy,char);
                end
        end

        def put(x=0,y=0,string,color:@color)
                @newframe[color]={} if (!@newframe.key? color);
                @newframe[color][y]={} if (!@newframe[color].key? y);
                @newframe[color][y][x]=string;
        end
        def puts(x=0,y=0,string,**args)
                s = string.length-1;
                for i in 0..s
                        self.put(x+i,y,string[i],**args);
                end
        end
        def puts!(x=0,y=0,string,color:@color)
                @screen.put(x+1,y+1,string);
        end

        def render(rl)
                rl.list.dup.each{ |k,o|
                        o.renderlist.each{ |r|
                                case r
                                when :renderPoint
                                        $canvas.draw(o.position[0],o.position[1],char:'X');
                                when :renderCircle
                                        $canvas.drawCircle(o.position[0],o.position[1],char:'.',radius:o.radius);
                                when :renderCustomPlot
                                        $canvas.plot(o.method(:renderCustomPlot),o.position[0],o.position[1],o.size[0],o.size[1],char:"y");
                                end
                        }
                }
        end

        def drawDebugInfo(x=0,y=0)
                self.puts!(0,0,"DI: PX FPS: #{@fps.round(2)} Dv: #{@drawsv} Dr: #{@drawsa} Dc: #{@drawsc}    ");
                @drawsv=0;
                @drawsa=0;
                @drawsc=0;
        end

        def initialize(screen)
                @char='.';
                @color="\e[39m";
                @zoom=1;
                @xyz=0,0,0;

                @screen=screen;

                # Render State:
                # 0: ready for action
                # 1: render request
                # 2: render request taken
                # 3: new render in queue

                @renderstate=0;

                # Debug stuff
                @fps=-1;
                @lastframetime=0;
                @drawsv=0;
                @drawsa=0;
                @drawsc=0;

                # Frame caching to render faster!
                # Get dem fps
                #@changes=[];
                @currentscreen={};
                @newframe={};

                $console.log('Start rendering thread');
                fps=60;
                # New thread for frame rendering and resizing check
                renderthr = Thread.new {
                        begin
                                while true
                                        self.sceneRender(); # expensive

                                        self.drawDebugInfo();

                                        leftovers=@currentscreen.dup;

                                        w=@screen.width;

                                        @newframe.each{ |color,v|
                                                # Change of color
                                                @screen.fg=color;

                                                v.each{ |y,v|
                                                        v.each{ |x,string|
                                                                @screen.put(x+1,y+1,string);

                                                                lid=x+y*w;
                                                                @currentscreen[lid]=string;
                                                                leftovers.delete(lid);
                                                        }
                                                }
                                        }
                                        @newframe={};

                                        # Clear screen leftovers
                                        leftovers.each{ |lid,v|
                                                y=(lid / w).floor.to_i;
                                                x=(lid % w);

                                                @screen.put(x+1,y+1,' ');
                                                @currentscreen.delete(lid);
                                        }

                                        # Calc real fps
                                        begin
                                                @fps=1.0/(Time.now.to_f-@lastframetime);
                                        rescue ZeroDivisionError
                                                @fps=-1;
                                        end
                                        @lastframetime=Time.now.to_f;

                                        # Everyone needs some rest
                                        Kernel::sleep(1.0/fps);
                                end
                        rescue StandardError => e
                                $console.error("CRITICAL: Canvas error: #{e}");
                        end
                }
        end
end

$canvas=Canvas.new($screen);
