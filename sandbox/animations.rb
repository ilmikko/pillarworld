# The UI should support animations
# Like:
#
# BG to white - left to right back to black and reveal text
# Flashing blue, scan left to right with white
# Scanning
# 255 colors?
# Fading in?
# Spinning .-\|/-\|/-

require('./canvas.rb');
require('./input.rb');

i=0;
x=0;
y=0;
animationid=0;

$input.listen({
	'h':->{
		x-=1;
	},
	'l':->{
		x+=1;
	},
	'j':->{
		y+=1;
	},
	'k':->{
		y-=1;
	},
	' ':->{
		animationid+=1;
	}
});

animations=["TI|I","I[I]","█◘◙"," ░▒▓█▓▒░"," ∙*☼#","→↑←↓","-=≡=","[]","`'\"'`","-+*+","(<->)|","-/|\\"];

while true
	i+=1;
	str=animations[animationid%animations.length];
	$canvas.draw(x,y,str[i%str.length]);
	sleep 0.1;
end

sleep;
