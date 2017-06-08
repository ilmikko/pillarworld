# UI handler

require('./console.rb');
require('./screen.rb');
#require('./canvas.rb');

class UIArea
        @@screen=$screen;

        def ixy;@ixy;end
        def ixy=(v)@ixy=v;end
        def iwh;@iwh;end
        def iwh=(v)@iwh=v;end

        def update()
                # catcher for empty area update
                # FIXME: remove later
        end

        def write(str,rx:0.5,ry:0.5,ax:0,ay:0,align: :left)
                # rx, ry are RELATIVE X and Y
                # ax, ay are ABSOLUTE X and Y
                if (ry<0)
                        # Line will be out of bounds anyway, so return now.
                        return;
                end

                sx=@xy[0];
                sy=@xy[1];
                w=@wh[0];
                h=@wh[1];

                x=(rx*w+ax).to_i;
                y=(ry*h+ay).to_i;

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
        def resize(x,y,w,h)
                # Update and store the actual x,y,w,h for rendering
                @xy=[x+@ixy[0]*w,y+@ixy[1]*h];
                @wh=[@iwh[0]*w,@iwh[1]*h];
        end
        def initialize(x=0,y=0,w=1,h=1)
                # Store the preferred x,y,w,h as floats from 0..1
                @xy=0,0;
                @wh=1,1;
                @ixy=x,y;
                @iwh=w,h;
        end
end

class UITextMultiline < UIArea
        def lines;@lines;end
        def lines=(v)@lines=v;end

        def textalign;@textalign;end
        def textalign=(v)@textalign=v;end

        def update()
                len=@lines.length;

                rx=0.5;
                ry=0.5;
                ax=0;
                ay=0;

                width=@lines.max_by{|x| x.length}.length;

                if (@align[0]==:left)
                        rx=0;
                        ax=width/2;
                elsif (@align[0]==:right)
                        rx=1;
                        ax=-width/2-1;
                end

                if (@align[1]==:top)
                        ry=0;
                elsif (@align[1]==:bot)
                        ry=1;
                        ay=-len;
                else
                        ay=-len/2+1;
                end

                if @textalign==:left
                        ax-=width/2;
                elsif @textalign==:right
                        ax+=width/2;
                end

                for i in 0...len
                        self.write(@lines[i],rx:rx,ry:ry,ax:ax,ay:ay+i,align:@textalign);
                end
        end

        def initialize(text='',ta: :center,ha: :center, va: :center)
                super(0,0,1,1);
                @lines=text.split("\n");
                @textalign=ta;
                @align=[ha, va];
        end
end

class UIText < UIArea
        def text;@text;end
        def text=(v);@text=v;end

        def update()
                rx=0.5;
                ry=0.5;
                ax=0;
                ay=0;

                if (@align[0]==:left)
                        rx=0;
                elsif (@align[0]==:right)
                        rx=1;
                        ax=-1;
                end

                if (@align[1]==:top)
                        ry=0;
                elsif (@align[1]==:bot)
                        ry=1;
                        ay=-1;
                end

                self.write(@text,rx:rx,ry:ry,ax:ax,ay:ay,align: @align[0]);
        end

        def initialize(text='',ha: :center, va: :center)
                super(0,0,1,1);
                @text=text;
                @align=[ha, va];
        end
end

class UIArray < UIArea
        def direction;@direction;end
        def direction=(v)@direction=v;end

        def append(*els)
                @elements.push(*els);
                self.readjust();
        end
        def prepend(*els)
                @elements.unshift(*els);
                self.readjust();
        end
        def readjust()
                len=@elements.length;
                part=1/len.to_f;
                if @direction==:row
                        for i in 0...len
                                @elements[i].ixy=[part*i,0];
                                @elements[i].iwh=[part,1];
                        end
                else
                        for i in 0...len
                                @elements[i].ixy=[0,part*i];
                                @elements[i].iwh=[1,part];
                        end
                end

                self;
        end
        def resize(x,y,w,h)
                super(x,y,w,h);
                x,y=@xy;
                w,h=@wh;

                len=@elements.length;
                for i in 0...len
                        @elements[i].resize(x,y,w,h);
                end
        end

        def update
                @elements.each{ |e|
                        e.update();
                }
        end

        def initialize(x=0,y=0,w=1,h=1,direction: :row)
                super(x,y,w,h);
                @elements=[];
                @direction=direction;
        end
end

class UI < UIArray
        def resize()
                @screen.clear();
                super(0,0,*@screen.dimensions);
        end
        def refresh
                self.resize();
                self.update();
        end
        def initialize(screen)
                super();

                @screen=screen;
                @focus=nil;

                this = self;
                @screen.on(:resize,->{
                        this.refresh();
                });
        end
end

$ui=UI.new($screen);
