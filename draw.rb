require('./canvas.rb');

class Draw
        def x;@xyz[0]end
        def x=(v)@xyz[0]=v;end
        def y;@xyz[1]end
        def y=(v)@xyz[1]=v;end
        def z;@xyz[2]end
        def z=(v)@xyz[2]=v;end
        def zoom;@zoom;end
        def zoom=(v)@zoom=v;end

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
                        $canvas.put(sx,sy,char);
                end
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

                                                $canvas.put(x,y,char);
                                        end
                                end
                        end
                rescue StandardError => e
                        $console.error("PLOT: ERROR #{e}");
                end
        end

        def render(rl)
                rl.list.dup.each{ |k,o|
                        o.renderlist.each{ |r|
                                case r
                                when :renderPoint
                                        self.draw(o.position[0],o.position[1],char:'X');
                                when :renderCircle
                                        self.drawCircle(o.position[0],o.position[1],char:'.',radius:o.radius);
                                when :renderCustomPlot
                                        self.plot(o.method(:renderCustomPlot),o.position[0],o.position[1],o.size[0],o.size[1],char:"y");
                                end
                        }
                }
        end

        def initialize(canvas)
                @char='.';
                @color="\e[39m";
                @zoom=1;
                @xyz=0,0,0;
                @screen=canvas.screen;
        end
end

$draw=Draw.new($canvas);
