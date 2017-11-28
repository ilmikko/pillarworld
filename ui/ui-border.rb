# 
# UIBorder
# An UIPadding with a visible display.
#
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
		$console.log("Border redrawing");
		w,h=@wh;
		x,y=@xy;

		cornerradius=1; # usually 1, shouldn't change this
		# change color
		print(@color) if @color;

		x=x.round.to_i;
		y=y.round.to_i;

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
		@@canvas.put(x,y,@characters[4]);
		# ne
		@@canvas.put(x+w-1,y,@characters[5]);
		# sw
		@@canvas.put(x,y+h-1,@characters[6]);
		# se
		@@canvas.put(x+w-1,y+h-1,@characters[7]);

		# Reset color
		print("\e[m") if @color;

		super; # remember to draw the child
	end

	def initialize(characters:@@default_characters,color:nil,**_)
		super(**_);

		self.color=color;
		self.characters=characters;
	end
end
