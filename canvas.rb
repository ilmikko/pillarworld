require("./screen.rb");

class Canvas
        def xy;@xy;end
        def xy=(v)@xy=v;end

        def x;@xy[0]end
        def x=(v)@xy[0]=v;end
        def y;@xy[1]end
        def y=(v)@xy[1]=v;end

        def zoom;@zoom;end
        def zoom=(v)@zoom=v;end

        def char;@char;end
        def char=(v);@char=v;end

        def insideCanvas?(sx,sy,w,h)
                return sx>=0&&sx<w&&sy>=0&&sy<h;
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
                                        if (f.call(cx,cy,m))
                                                x=sx+cx;
                                                y=sy+cy;

                                                @screen.put(x,y,char);
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
                },centerx,centery,radius*2,radius*2,char:char);
        end

        def put(x=0,y=0,char: @char)
                # Translate to screen coordinates (zoom plus center)
                m=@zoom;
                w,h=@screen.dimensions;
                sx=(x*m+w/2-self.x*m).to_i;
                sy=(y*m+h/2-self.y*m).to_i;

                if (insideCanvas? sx,sy,w,h)
                        @screen.put(sx,sy,char);
                end
        end

        def render(rl)
                rl.list.dup.each{ |k,o|
                        o.renderlist.each{ |r|
                                case r
                                when :renderPoint
                                        $canvas.put(*o.position,char:"X");
                                when :renderCircle
                                        $canvas.drawCircle(*o.position,char:".",radius:o.radius);
                                when :renderCustomPlot
                                        $canvas.plot(o.method(:renderCustomPlot),*o.position,*o.size,char:"y");
                                end
                        }
                }
        end

        def initialize(screen)
                @char=".";
                @zoom=1;
                @xy=0,0;
                @screen=screen;
        end
end

$canvas=Canvas.new($screen);
