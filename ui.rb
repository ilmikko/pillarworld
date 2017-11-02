# UI handler
# NOTE: Obsolete! Go to ./ui to find the newest version of this.

require('./console.rb');
require('./canvas.rb');

require('./ui-animation.rb');

class UINode
        # Public functions every atom should have
        @@screen=$screen;
	@@canvas=$canvas;

	# Definitions that are across all objects, or "common sense"
	@@colors={
		default:"\e[0m",
		blue:"\e[034m"
	};

        def parent;@parent;end
        def parent=(v);@parent=v;end

	def id;@id;end
	def id=(v);@id=v;end

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

        def initialize(id: nil)
		@id=id;
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
	@@default_color=:default;

        def length;@length;end

	def color;@color;end
	def color=(v);
		if (v.is_a? String)
			@color=v;
		elsif (v.is_a? Symbol)
			@color=@@colors[v];
		end
	end

        def text;@text;end
        def text=(v);
                @text=v;
                @length=v.length;
                # We can know the size of this element by the length of the text
                # UIText never spans multiple lines
                @wh=[@length,1];
        end

	def crop;@crop;end
	def cropx(cl=0,cr=0)
		# cy, or 'y crop' is either zero or over. If it's zero, the text is visible, if it's over zero, the text is effectively hidden.
		@crop[0,1]=cl,cr;
	end
	def cropy(cy=0)
		@crop[2]=cy;
	end

	def reflow(x,y,w,h)
		#super # We don't call super here, as we don't want to set our width just because of the container we're in.
		@xy=[x,y];
	end

        def redraw
		return if (@crop[2]>0); # Return if y crop is >0

		xy=@xy;
		text=@text.dup;
		len=text.length;
		cl,cr=@crop;

		text=text[cl...len-cr]||'';
		xy[0]+=cl; # Offset the left start to compensate for the crop

                @@canvas.draw(*xy, text, color:@color);
        end

        def initialize(text='',color: @@default_color,**_)
                super(**_);

		@crop=[0,0];
		@visible=true;

		self.color=color;
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

        def initialize(**_)
                super(**_);

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

			textalign = (w-lw) * ar;

                        # next line in word wrap
			if (ox+c.width>lw)
				ox=0;
				oy+=1;
				wh[1]=oy+1; # No need for 'if' because we know it's bigger; it only increments
			end

			if (ox==0&&c.width>=w)
				# The word is too big for the line
				#$console.debug("Too beeg: #{c.text}");
				c.cropx((ar)*(lw-w),(1-ar)*(lw-w));
			else
				c.cropx();
			end

			if (oy<h)
				c.cropy();
			else
				c.cropy(1);
			end

			#$console.debug("TEXT ALIGN: w:#{w} lw:#{lw} #{w-lw}");

			wh[0]=lw if (lw>wh[0]);

			c.reflow(x+ox+textalign,y+oy,w,1);

                        ox+=c.width;
                end

		@xy=x,y;
		@wh=wh;
        end

	def append(*stuff)
		# We accept .append("text") instead of .append(UIText.new('text')) - they're equivalent.
		arr=stuff.map{ |item|
			if (item.is_a? String)
				words=item.strip.split(/(\s)+/);
				words.map{ |word|
					UIText.new(word);
				};
			else
				item;
			end
		}.flatten;
		$console.log(arr);
		super(*arr);
	end

        def initialize(*append,textalign: :left,**_)
                super(**_);

		self.textalign=textalign;
		self.append(*append);
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

		# Don't need to reflow
		# If you don't have any children
		if len>0
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
        end

	def initialize(direction: :row,**_)
                super(**_);
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

			# Remove oy from h to state the available height for the text elements
			c.reflow(x,y+oy,w,h-oy);

			oy+=c.wh[1];
		end
	end
end

class UI < UIFlex
        def update
		reflow();
                @@screen.clear();
                redraw();
        end

	def reflow(*)
                super(0,0,*@@screen.dimensions);
	end

        def show(*elems)
                $console.debug("UI: Show: #{elems}");
                empty;
                append(*elems);
                update;
        end

        def initialize()
                super();

                @parent=self;

                this=self;
                @@screen.on(:resize,->{
                        this.update;
                });
        end
end

$ui=UI.new();
