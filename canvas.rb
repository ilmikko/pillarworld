require("./screen.rb");

class Area
        @@screen=$screen;

        def screensize
                @screensize
        end

        def write(str,x,y,align: :left)
                if (y<0)
                        # Line will be out of bounds anyway, so return now.
                        return;
                end

                w=@dimensions[0];
                h=@dimensions[1];
                sx=@position[0];
                sy=@position[1];

                x=(x*w).to_i;
                y=(y*h).to_i;

                if (x>w||y>h)
                        # Starting point out of bounds
                        return;
                end

                sl=str.length;

                if (align==:center)
                        x-=sl/2-1;
                elsif (align==:right)
                        x-=sl-1;
                end

                if (x<0)
                        str=str[-x..-1];
                        x=0;
                end

                if (x+sl>w)
                        str=str[0..w-x-1];
                end

                @@screen.put((sx+x+1).to_i,(sy+y+1).to_i,str);
        end
        def writeLines(x,y,lines,**args)
                len=lines.length-1;
                lines.each_with_index{ |l,i|
                        self.write(x,y-len+i,l,**args);
                }
        end
        def update(w,h)
                @screensize=[w,h];
                @dimensions=[w*@wh[0],h*@wh[1]];
                @position=[w*@xy[0],h*@xy[1]];
        end
        def initialize(x,y,w,h)
                @xy=x,y;
                @wh=w,h;
                self.update();
        end
end

class Canvas < Area
        def update()
                super(*@@screen.dimensions);
        end
        def initialize
                super(0,0,1,1);
        end
end

$canvas=Canvas.new;
