# UI handler

require('./console.rb');
require('./screen.rb');
#require('./canvas.rb');

class UINode
        # Public functions every atom should have
        @@screen=$screen;
        def parent;@parent;end
        def parent=(v);@parent=v;end

        # size: [w,h] in pixels
        def wh;@wh;end
        def wh=(v);@wh=v;end

        def width;@wh[0];end
        def height;@wh[1];end

        # position: [x,y] in pixels
        def xy;@xy;end
        def xy=(v);@xy=v;end

        # Reflow: when our size and position must change
        def reflow(x,y,w,h)
		$console.log("REFLOW: #{self} #{x},#{y},#{w},#{h}");
                @xy=[x,y];
                @wh=[w,h];
        end

        def initialize
                @xy=[0,0];
                @wh=[0,0];
        end

        # Redraw: when there is a need for a redraw (for example, the text has changed)
        # Old update
        def redraw
                $console.warn("Redraw fallback function");
        end
end

class UIText < UINode
        def length;@length;end

        def text;@text;end
        def text=(v);
                @text=v;
                @length=v.length;
                # We can know the size of this element by the length of the text
                # UIText never spans multiple lines
		$console.debug("Hi I'm '#{@text}' and my length is #{@length}");
                @wh=[@length,1];
        end

	def crop;@crop;end
	def crop(cl=0,cr=0);
		@crop=cl,cr;
	end

	def visible;@visible;end
	def visible=(v);@visible=v;end;

	def reflow(x,y,w,h)
		#super # We don't call super here, as we don't want to set our width just because of the container we're in.
		@xy=[x,y];
	end

        def redraw
		return if (!@visible);
                #$console.log("Redrawing text #{@text}");

                #@clear.() if @clear;
                #@clear=@@parent.write(@text,pivot:@pivot,offset:@offset);

                #x,y=@xy;
                #l = @text.length;

		xy=@xy;
		text=@text.dup;
		len=text.length;
		cl,cr=@crop;

		text=text[cl...len-cr]||'';
		xy[0]+=cl; # Offset the left start to compensate for the crop

                @@screen.put(*xy,text);
        end

        def initialize(text='')
                super();

		@crop=[0,0];
		@visible=true;

                self.text=text;
        end
end

class UIArray < UINode
        def append(*items)
                this=self;
                items.each{ |c|
                        @children.push(c);
                        c.parent=this;
                }

                self;
        end
        def empty
                @children.clear;
        end

        def reflow(x,y,w,h)
                super(x,y,w,h);

		# Default UIArray behavior is to reflow directly to the children,
		# thus "ignoring" the array's existence.

                @children.each{ |c|
                        c.reflow(x,y,w,h);
                }
        end

        def redraw
                @children.each{ |c|
                        c.redraw;
                }
        end

        def initialize
                super();

                @children=[];
        end
end

class UIParagraph < UIArray
        def textalign;@textalign;end
        def textalign=(v);
                @textalign=v;
        end

	def reflow(x,y,w,h)
                len=@children.length;

		ox=0;
		oy=0;
		wh=[0,1];

		ar=0;

		if (@textalign==:center)
			ar=0.5;
		elsif (@textalign==:right)
			ar=1;
		end

                $console.log("REFLOW PARAGRAPH: #{self} #{x},#{y},#{w},#{h}");

		tick=0; # TODO: Better name for the tick. Tick is the method of remembering when to calc a new line's width.

                for i in 0...len
			c=@children[i];
			if (i==tick)
				# calc the next line width
				lw=c.width; # Line width is never 0, and always has one child regardless of its width.
				for j in i+1...len
					# Calc if we can fit any more children here
					d=@children[j];
					if (lw+d.width<=w)
						lw+=d.width;
					else
						tick=j;
						break;
					end
				end
				#$console.debug("Line \##{oy} width: #{lw}");
			end

			textalign = (w - lw) * ar;

                        # next line in word wrap
			if (ox+c.width>lw)
				ox=0;
				oy+=1;
				wh[1]=oy+1; # No need for 'if' because we know it's bigger; it only increments
			end

			if (ox==0&&c.width>=w)
				# The word is too big for the line
				#$console.debug("Too beeg: #{c.text}");
				c.crop((ar)*(lw-w),(1-ar)*(lw-w));
			else
				c.crop();
			end

			#$console.debug("TEXT ALIGN: w:#{w} lw:#{lw} #{w-lw}");

			wh[0]=lw if (lw>wh[0]);

			c.visible=(oy<h);

			c.reflow(x+ox+textalign,y+oy,w,1);

                        ox+=c.width;
                end

		self.wh=wh;
		#$console.debug("#{self} size is #{wh}");
        end

        def initialize(text=nil,textalign: :left)
                super();

		self.textalign=textalign;

		if (text)
			texts=text.split(/(\s)/);
			len=texts.length;

			for g in 0...len
				texts[g]=UIText.new(texts[g]);
			end

			self.append(*texts);
		end
        end
end

class UIFlex < UIArray
        def append(*items)
                super(*items);
                # reflow with the same parameters
                reflow(*@xy,*@wh);
                self;
        end

        def reflow(x,y,w,h)
                len=@children.length;

		$console.log("Flex reflow: #{x} #{y} #{w} #{h}");

                if @direction==:row
                        part=w/len;

                        for i in 0...len
                                c=@children[i];

                                c.reflow(x+part*i,y,part,h);
                        end
                else
                        part=h/len;

                        for i in 0...len
                                c=@children[i];

                                c.reflow(x,y+part*i,w,part);
                        end
                end
        end

        def initialize(direction: :row)
                super();
                @direction=direction;
        end
end

class UITextArea < UIArray
	def reflow(x,y,w,h)
		len=@children.length;

		oy=0;

		$console.log("TextArea reflow: #{x} #{y} #{w} #{h}");

		for i in 0...len
			c=@children[i];

			c.reflow(x,y+oy,w,h);

			oy+=c.wh[1];
		end
	end
end

class UI < UIFlex
        def resize
                reflow(0,0,*@@screen.dimensions);

                @@screen.clear();
                redraw;
        end

        def show(*elems)
                $console.debug("UI: Show: #{elems}");
                empty;
                append(*elems);
                resize;
        end

        def initialize()
                super();

                @parent=self;

                this=self;
                @@screen.on(:resize,->{
                        this.resize;
                });
        end
end

$ui=UI.new();
