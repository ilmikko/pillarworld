# UI handler

require('../console.rb');
require('../canvas.rb');

require('./ui-animation.rb');

class UINode
        # Public functions every atom should have
        @@screen=$screen;
	@@canvas=$canvas;

	# Definitions that are across all objects, or "common sense"
	#
	# COLORS
	@@colors={
		# TODO: These aren't really colors. You can also have strikethrough red text, but not red blue text.
		#strikethrough:"\e[009m",
		#negative:"\e[007m",
		default:"\e[0m",
		gray:"\e[030m",
		red:"\e[031m",
		green:"\e[032m",
		yellow:"\e[033m",
		blue:"\e[034m",
		magenta:"\e[035m",
		cyan:"\e[036m",
		lightgray:"\e[037m"
	};
	@@default_color=nil;
	def color;@color;end
	def color=(v);
		if (v.is_a? String)
			@color=v;
		elsif (v.is_a? Symbol)
			@color=@@colors[v];
		elsif (v.nil?)
			@color=nil;
		end
	end

        def parent;@parent;end
        def parent=(v);@parent=v;end

	def id;@id;end
	def id=(v);@id=v;end

        # position: [x,y] in pixels
	def xy;[self.x,self.y];end
	def x;@xy[0];end
	def y;@xy[1];end

	def x=(v);
		@xy[0]=v;
	end
	def y=(v);
		@xy[1]=v;
	end

	def xy=(xy);
		self.x=xy[0];
		self.y=xy[1];
	end

        # size: [w,h] in pixels
	def wh;[self.w,self.h];end
        def w;@wh[0];end
        def h;@wh[1];end

	def w=(v);
		v=@preferredwh[0] if !@preferredwh[0].nil? && v>@preferredwh[0];
		@wh[0]=v;
	end
	def h=(v);
		v=@preferredwh[1] if !@preferredwh[1].nil? && v>@preferredwh[1];
		@wh[1]=v;
	end

	def wh=(wh);
		self.w=wh[0];
		self.h=wh[1];
	end

	def xywh=(xywh);
		self.xy=xywh[0..1];
		self.wh=xywh[2..3];
	end

	def change;end # Hook for something has changed

        def initialize(id: nil,width:nil,height:nil)
		@id=id;
                @xy=[0,0];
                @wh=[0,0];
		@preferredwh=[width,height];
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
		@preferredwh[0]=@length;
		self.w=@length;
		self.change;
        end

	def crop;@crop;end
	def cropx(cl=0,cr=0)
		# cy, or 'y crop' is either zero or over. If it's zero, the text is visible, if it's over zero, the text is effectively hidden.
		@crop[0..1]=cl,cr;
	end
	def cropy(cy=0)
		@crop[2]=cy;
	end

	def change
		#x,y=@xy;
		#w,h=@wh;

		#pw,ph=@parent.wh;
		#px,py=@parent.xy;
		#
		#@crop[0]=[px-x,0].max;
		#@crop[1]=[w-pw-px+x,0].max;
		#@crop[2]=y-ph-py;
	end

        def redraw
		return if (@crop[2]>0); # Return if y crop is >0

		xy=@xy;
		text=@text.dup;
		len=text.length;
		cl,cr=@crop;

		text=text[cl...(len-cr)]||'';
		xy[0]+=cl; # Offset the left start to compensate for the crop

                @@canvas.write(*xy, text, color:@color);
        end

        def initialize(text='',color: @@default_color,**_)
                super(**_);

		@crop=[0,0,0];
		@visible=true;
		@wh=[0,1];
		@preferredwh=[0,1];

		self.color=color;
                self.text=text;
        end
end

class UIPass < UINode
	# Pass doesn't do much on its own. It just passes everything to its child like it wasn't there at all.
	def children;[@child];end

	def change;
		@child.xywh=[*@xy,*@wh];
		@child.change;
	end

	def redraw;
		@child.redraw;
	end

	def append(child);
		@child=child;
		@child.parent=self;
	end
end

# this might replace UITextArea and textAlign in UIParagraph (if we get paragraph to not use all of its space)
class UIAlign < UIPass
	def horizontalalign;@horizontalalign;end
	@@verticalaligns={
		top:0,
		center:0.5,
		bottom:1
	}
	@@horizontalaligns={
		left:0,
		center:0.5,
		right:1
	}

	def verticalalign;
		@@verticalaligns.key(@verticalalign);
	end
	def verticalalign=(v);
		@verticalalign=@@verticalaligns[v];
	end

	def horizontalalign;
		@@horizontalaligns.key(@horizontalalign);
	end
	def horizontalalign=(v);
		@horizontalalign=@@horizontalaligns[v];
	end

	def change;
		w,h=@wh;
		x,y=@xy;

		@child.wh=@wh;
		@child.change;
		# calc aligns, position
		cw,ch=@child.wh;
		
		ha=(w-cw)*@horizontalalign;
		va=(h-ch)*@verticalalign;

		@child.xy=[x+ha,y+va];
		@child.change;
	end

	def initialize(horizontalalign: :center, verticalalign: :center,**_)
		super(**_);
		self.horizontalalign=horizontalalign;
		self.verticalalign=verticalalign;
	end
end

class UIPadding < UIPass
	@@default_padding=1;

	def padding;@padding;end
	def padding=(v);@padding=v;end

	def change;
		w,h=@wh;
		x,y=@xy;

		width=@padding;
		@child.xywh=[x+width,y+width,w-width*2,h-width*2];
		@child.change;
	end

	def initialize(padding:1,**_)
		super(**_);

		self.padding=padding;
	end
end

class UIBorder < UIPadding
	@@default_characters='─│┌┐└┘';

	def characters;@characters;end
	def characters=(v);
		v=@@default_characters if !v||v.length==0;
		raise SyntaxError('Too many characters for border!') if v.length>8;
		while v.length<8
			v<<v if v.length==1;
			v<<v[-1] if v.length==3||v.length==5||v.length==7;
			v=v.split(//).map{|c|c<<c}.join if v.length==2||v.length==4;
			v=v[0..1].split(//).map{|c|c<<c}.join+v[2..5] if v.length==6;
		end
		@characters=v;
	end

	def redraw;
		super; # remember to draw the child

		w,h=@wh;
		x,y=@xy;

		cornerradius=1; # usually 1, shouldn't change this
		# change color
		@@canvas.color(@color) if @color;

		# Draw lines

		# top
		@@canvas.hline(x+cornerradius,y,w-cornerradius*2,char: @characters[0]);

		# bottom
		@@canvas.hline(x+cornerradius,y+h-1,w-cornerradius*2,char: @characters[1]);

		# left
		@@canvas.vline(x,y+cornerradius,h-cornerradius*2,char: @characters[2]);

		# right
		@@canvas.vline(x+w-1,y+cornerradius,h-cornerradius*2,char: @characters[3]);

		# Draw corners
		# nw
		@@canvas.draw(x,y,char: @characters[4]);
		# ne
		@@canvas.draw(x+w-1,y,char: @characters[5]);
		# sw
		@@canvas.draw(x,y+h-1,char: @characters[6]);
		# se
		@@canvas.draw(x+w-1,y+h-1,char: @characters[7]);

		@@canvas.endcolor;
	end

	def initialize(characters: @@default_characters,color: @@default_color,**_)
		super(**_);

		self.color=color;
		self.characters=characters;
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

	def change
		x,y=@xy;
		w,h=@wh;

		@children.each{ |c|
			c.xywh=[*@xy,*@wh];
			c.change;
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
	@@textaligns={
		left:0,
		center:0.5,
		right:1
	};
        def textalign;
		@@textaligns.key(@textalign);
	end
        def textalign=(v);
                @textalign=@@textaligns[v];
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
		super(*arr);
	end

	def change
		x,y=@xy;
		w,h=@wh;
		
		linewidth=0;
		linec=0;

		@preferredwh=[0,0];

		ox=0;
		oy=0;

		len=@children.length;

		nextLine=0;

		for i in 0...len
			c=@children[i];

			if (i==nextLine)
				# Calc the next line width
				linewidth=c.w;
				
				for j in i+1...len
					# Calc if we can fit any more children here
					d=@children[j];
					if (linewidth+d.w<=w)
						# yes we can!
						linewidth+=d.w;
					else
						# nope, do this again when i hits this child
						nextLine=j;
						break;
					end
				end
			end
			
			alignoffset = (w-linewidth)*@textalign;

			# next line in word wrap
			if (ox+c.w>linewidth)
				ox=0;
				oy+=1;
			end

			c.xy=[x+ox+alignoffset,y+oy];
			c.change;

			ox+=c.w;

			@preferredwh[0]=ox if ox>@preferredwh[0];
		end

		@preferredwh[1]=oy+1;
	end

        def initialize(*append,textalign: :left,**_)
                super(**_);

		self.textalign=textalign;
		self.append(*append);
        end
end

class UITextArea < UIArray
	@@verticalaligns={
		top:0,
		center:0.5,
		bottom:1
	}

	def verticalalign;
		@@verticalaligns.key(@verticalalign);
	end
	def verticalalign=(v);
		@verticalalign=@@verticalaligns[v];
	end
	def change
		len=@children.length;

		# 1. Calculate how much our paragraphs will be squished on the x axis - word wrap the children, get their heights individually
		# 2. Using the combined height of the child elements, calculate the positions of the children according to our vertical align
		x,y=@xy;
		w,h=@wh;

		ox,oy=[0,0];

		for i in 0...len
			c=@children[i];

			# Remove oy from h to state the available height for the text elements
			c.xywh=[x,y+oy,w,h-oy];
			c.change;

			oy+=c.h;
			#c.y=10;#y+oy;
		end

		# oy is now known, the total height of our children.
		# We can now totally work out the vertical align.
		verticaloffset=(h-oy)*@verticalalign;

		@children.each{|c|
			c.y+=verticaloffset;
			c.change;
		}
	end
	def initialize(verticalalign: :top,**_)
		super(**_);
		self.verticalalign=verticalalign;
	end
end

class UIFlex < UIArray
        def append(*items)
                super(*items);
                self;
        end

	def change
		len=@children.length.to_f;

		w,h=@wh;
		x,y=@xy;

		# Don't need to reflow
		# If you don't have any children
		if len>0
			if @direction==:row
				part=w/len;

				for i in 0...len
					c=@children[i];
					c.xywh=[x+part*i,y,part,h];
					c.change;
				end
			else
				part=h/len;

				for i in 0...len
					c=@children[i];
					c.xywh=[x,y+part*i,w,part];
					c.change;
				end
			end
		end
	end

	def initialize(direction: :row,**_)
                super(**_);
                @direction=direction;
        end
end

class UI < UIArray
        def update
		reflow();
                @@screen.clear();
                redraw();
        end

	def reflow()
		self.xywh=[0,0,*@@screen.dimensions];
		self.change;
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
