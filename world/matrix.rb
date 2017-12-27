# 3D matrix transformations boii!
# Press space to change the axis of rotation.

$LOAD_PATH.push('../lib');

require('console');
require('input');
require('view');

require('matrix');

$screen=Screen.new;
$view=View::Performance.new(0,0,90,30,screen:$screen,fps:60);
$view2=View.new(0,30,90,20,screen:$screen);

$view2.scene=->(){
	$console.log("Redrawing scene2");
	$view2.put(0,0,"Hello World!");
};

$perspective=1.1;

def putc(x,y,z,c)
	w,h=$view.wh;
	# perspective translation
	x*=$perspective**z;
	y*=$perspective**z;

	x+=w/2;
	y+=h/2;

	$view.put(x,y,c);
end

class Box
	def rotateX(deg)
		@matrix*=Matrix[[1,0,0],[0,Math.cos(deg),Math.sin(deg)],[0,-Math.sin(deg),Math.cos(deg)]];
	end
	def rotateY(deg)
		@matrix*=Matrix[[Math.cos(deg),0,Math.sin(deg)],[0,1,0],[-Math.sin(deg),0,Math.cos(deg)]];
	end
	def rotateZ(deg)
		@matrix*=Matrix[[Math.cos(deg),-Math.sin(deg),0],[Math.sin(deg),Math.cos(deg),0],[0,0,1]];
	end
	def put(x,y,z,c)
		selfmatrix=Matrix[[x],[y],[z]];
		transform=@matrix*selfmatrix;
		x=transform[0,0]
		y=transform[1,0]
		z=transform[2,0]
		## Debug
		#puts(transform)
		#puts("X: #{x}, Y: #{y}, Z: #{z}")
		#sleep(1)
		putc(x,y,z,c);
	end
	def draw()
		x,y,z=@x,@y,@z;

		put(x-@w/2,y-@h/2,z-@d/2,'1')
		put(x-@w/2,y-@h/2,z+@d/2,'9')
		put(x+@w/2,y-@h/2,z-@d/2,'2')
		put(x+@w/2,y-@h/2,z+@d/2,'8')
		put(x-@w/2,y+@h/2,z-@d/2,'3')
		put(x-@w/2,y+@h/2,z+@d/2,'7')
		put(x+@w/2,y+@h/2,z-@d/2,'4')
		put(x+@w/2,y+@h/2,z+@d/2,'6')

		put(x,y,z,'X');
	end
	def initialize(x:0,y:0,z:0,w:10,h:10,d:10)
		@x,@y,@z=x,y,z;
		@w,@h,@d=w,h,d;
		@matrix=Matrix.identity(3);
	end
end

$box=Box.new#(w:$screen.width/10,h:$screen.height/10);

$axis=0;
$input.listen({
	' ':->{
		$axis=($axis+1)%3;
	}
});

$view.scene=->(){
	d=0.03;
	$view.clear;
	$box.draw()
	if $axis==0
		$box.rotateX(d)
	elsif $axis==1
		$box.rotateY(d)
	else
		$box.rotateZ(d)
	end
};

sleep;
