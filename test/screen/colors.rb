require_relative('../screen');

# In optimal mode, we use the true range of colors.
# In reduce mode, we only use the 256 colors available.
# In bare mode, we only use the system colors.

class ScreenHelper < Screen
	def putr(x,y,str)
		put(x-str.length,y,str);
	end
	def put(x,y,str,color: nil)
		print(color) if !color.nil?;
		super(x,y,str);
	end
end

screen=ScreenHelper.new;

def raw(x,y,screen)
	# Raw colors (standard, may change)
	print("\e[30m");
	screen.put(x+0,y,"#");
	print("\e[31m");
	screen.put(x+1,y,"#");
	print("\e[32m");
	screen.put(x+2,y,"#");
	print("\e[33m");
	screen.put(x+3,y,"#");
	print("\e[34m");
	screen.put(x+4,y,"#");
	print("\e[35m");
	screen.put(x+5,y,"#");
	print("\e[36m");
	screen.put(x+6,y,"#");
	print("\e[37m");
	screen.put(x+7,y,"#");
end

def rawhi(x,y,screen)
	# High intensity colors (non standard)
	print("\e[90m");
	screen.put(x+0,y,"#");
	print("\e[91m");
	screen.put(x+1,y,"#");
	print("\e[92m");
	screen.put(x+2,y,"#");
	print("\e[93m");
	screen.put(x+3,y,"#");
	print("\e[94m");
	screen.put(x+4,y,"#");
	print("\e[95m");
	screen.put(x+5,y,"#");
	print("\e[96m");
	screen.put(x+6,y,"#");
	print("\e[97m");
	screen.put(x+7,y,"#");
end

def raw256(x,y,screen)
	print("\e[38;5;0m");
	screen.put(x+0,y,"#");
	print("\e[38;5;9m");
	screen.put(x+1,y,"#");
	print("\e[38;5;10m");
	screen.put(x+2,y,"#");
	print("\e[38;5;11m");
	screen.put(x+3,y,"#");
	print("\e[38;5;12m");
	screen.put(x+4,y,"#");
	print("\e[38;5;13m");
	screen.put(x+5,y,"#");
	print("\e[38;5;14m");
	screen.put(x+6,y,"#");
	print("\e[38;5;15m");
	screen.put(x+7,y,"#");
end

def rawtrue(x,y,screen)
	print("\e[38;2;0;0;0m");
	screen.put(x+0,y,"#");
	print("\e[38;2;255;0;0m");
	screen.put(x+1,y,"#");
	print("\e[38;2;0;255;0m");
	screen.put(x+2,y,"#");
	print("\e[38;2;255;255;0m");
	screen.put(x+3,y,"#");
	print("\e[38;2;0;0;255m");
	screen.put(x+4,y,"#");
	print("\e[38;2;255;0;255m");
	screen.put(x+5,y,"#");
	print("\e[38;2;0;255;255m");
	screen.put(x+6,y,"#");
	print("\e[38;2;255;255;255m");
	screen.put(x+7,y,"#");
end

def screenprint(x,y,screen)
	#$console.log(Screen::Color[:red]);
	print(Screen::Color[:black]);
	screen.put(x+0,y,"#");
	print(Screen::Color[:red]);
	screen.put(x+1,y,"#");
	print(Screen::Color[:green]);
	screen.put(x+2,y,"#");
	print(Screen::Color[:yellow]);
	screen.put(x+3,y,"#");
	print(Screen::Color[:blue]);
	screen.put(x+4,y,"#");
	print(Screen::Color[:magenta]);
	screen.put(x+5,y,"#");
	print(Screen::Color[:cyan]);
	screen.put(x+6,y,"#");
	print(Screen::Color[:white]);
	screen.put(x+7,y,"#");
end

def screenput(x,y,screen)
	screen.put(x+0,y,"#",color: Screen::Color[:black]);
	screen.put(x+1,y,"#",color: Screen::Color[:red]);
	screen.put(x+2,y,"#",color: Screen::Color[:green]);
	screen.put(x+3,y,"#",color: Screen::Color[:yellow]);
	screen.put(x+4,y,"#",color: Screen::Color[:blue]);
	screen.put(x+5,y,"#",color: Screen::Color[:magenta]);
	screen.put(x+6,y,"#",color: Screen::Color[:cyan]);
	screen.put(x+7,y,"#",color: Screen::Color[:white]);
end

def screenputcust(x,y,screen)
	screen.put(x+0,y,"#",color: Screen::Color[0,0,0]);
	screen.put(x+1,y,"#",color: Screen::Color[255,0,0]);
	screen.put(x+2,y,"#",color: Screen::Color[0,255,0]);
	screen.put(x+3,y,"#",color: Screen::Color[255,255,0]);
	screen.put(x+4,y,"#",color: Screen::Color[0,0,255]);
	screen.put(x+5,y,"#",color: Screen::Color[255,0,255]);
	screen.put(x+6,y,"#",color: Screen::Color[0,255,255]);
	screen.put(x+7,y,"#",color: Screen::Color[255,255,255]);
end

x=1;
y=1;
col=14;

x+=col;
	screen.put(x,y,"\e[mRaw Sys");
	x+=col;
		screen.put(x,y,"\e[mRaw HI");
		x+=col;
			screen.put(x,y,"\e[mRaw 256");
			x+=col;
				screen.put(x,y,"\e[mRaw True");
			x-=col;
		x-=col;
	x-=col;
x-=col;

y+=2;

# First, raw way to change color
x+=col;
	raw(x,y,screen);
	x+=col;
		rawhi(x,y,screen);
		x+=col;
			raw256(x,y,screen);
			x+=col;
				rawtrue(x,y,screen);
			x-=col;
		x-=col;
	x-=col;
x-=col;

# Divisor
y+=2;
screen.hline(x,y,80-x-1,char:'-');

y+=2;
x+=col;
	screen.put(x,y,"\e[mScreen print");
	x+=col;
		screen.put(x,y,"\e[mScreen sug");
		x+=col;
			screen.put(x,y,"\e[mScreen cust");
		x-=col;
	x-=col;
x-=col;

# Screen, a better way to change color (and ensure it works across platforms)
y+=2;
screen.putr(x+col,y,"\e[mOptimal");
Screen::Color.mode=:optimal;

x+=col;
	screenprint(x,y,screen);
	x+=col;
		screenput(x,y,screen);
		x+=col;
			screenputcust(x,y,screen);
		x-=col;
	x-=col;
x-=col;

y+=2;
screen.putr(x+col,y,"\e[mReduced");
Screen::Color.mode=:reduced;

x+=col;
	screenprint(x,y,screen);
	x+=col;
		screenput(x,y,screen);
		x+=col;
			screenputcust(x,y,screen);
		x-=col;
	x-=col;
x-=col;

y+=2;
screen.putr(x+col,y,"\e[mBare");
Screen::Color.mode=:bare;

x+=col;
	screenprint(x,y,screen);
	x+=col;
		screenput(x,y,screen);
		x+=col;
			screenputcust(x,y,screen);
		x-=col;
	x-=col;
x-=col;

y+=2;
screen.putr(x+col,y,"\e[mSystem");
Screen::Color.mode=:system;

x+=col;
	screenprint(x,y,screen);
	x+=col;
		screenput(x,y,screen);
		x+=col;
			screenputcust(x,y,screen);
		x-=col;
	x-=col;
x-=col;

sleep;
