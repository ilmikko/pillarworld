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

                x=(centerx*m+dw/2).to_i;
                y=(centery*m+dh/2).to_i;

                heighthalf=(height/2*m).to_i;
                widthhalf=(width/2*m).to_i;

                # The minimums and maximums are to speed up the process of drawing very large circles
                # We don't have to check areas that are outside the viewport

                for cy in -([heighthalf,y].min)..([heighthalf,dh-y].min)
                        for cx in -([widthhalf,x].min)..([widthhalf,dw-x].min)
                                begin
                                        if (f.call(cx,cy,m))
                                                # check if screen x and y are out of range
                                                sx=x+cx;
                                                sy=y+cy;

                                                @screen.put(sx,sy,char);
                                        end
                                rescue StandardError => e
                                        $console.error("PLOT: ERROR #{e}");
                                end
                        end
                end
        end

        def draw(x=0,y=0,char: @char)
                # Translate to screen coordinates (zoom plus center)
                m=@zoom;
                w,h=@screen.dimensions;
                sx=(x*m+w/2).to_i;
                sy=(y*m+h/2).to_i;

                if (insideCanvas? sx,sy,w,h)
                        @screen.put(sx,sy,char);
                end
        end
        def drawCircle(centerx=0,centery=0,radius: 1,char: @char)
                self.plot(->(x,y,m){
                        return y*y+x*x<radius*radius*m*m;
                },centerx,centery,radius*2,radius*2,char:char);
        end
        def initialize(screen)
                @char=".";
                @zoom=1;
                @xy=0,0;
                @screen=screen;
        end
end

$canvas=Canvas.new($screen);
