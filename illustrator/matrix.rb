#
# Challenge: implement world/matrix.rb as a UIView element.
# Try to optimize it as much as possible. We don't have screen redraws anymore, for example.
#

$LOAD_PATH.push('../lib');

PERSPECTIVE=1.1;

Thread.abort_on_exception=true;

require('console');
$console.loglevel=-1000;
$console.debug('Debug messages work');

require('matrix');
class Box3D
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
		# Transform local x,y,z by matrix
		transform=@matrix*Matrix[[x],[y],[z]];
		
		# Get resulting (global) x,y,z
		x=transform[0,0]
		y=transform[1,0]
		z=transform[2,0]

		# Draw em
		putz(x,y,z,c);
	end
	def draw()
		x,y,z=@x,@y,@z;

		put(x-@w/2,y-@h/2,z-@d/2,'1');
		put(x+@w/2,y-@h/2,z-@d/2,'2');
		put(x-@w/2,y+@h/2,z-@d/2,'3');
		put(x+@w/2,y+@h/2,z-@d/2,'4');
		put(x-@w/2,y-@h/2,z+@d/2,'5');
		put(x+@w/2,y-@h/2,z+@d/2,'6');
		put(x-@w/2,y+@h/2,z+@d/2,'7');
		put(x+@w/2,y+@h/2,z+@d/2,'8');

		put(x,y,z,'X');
	end
	def initialize(x:0,y:0,z:0,w:10,h:10,d:10)
		@x,@y,@z=x,y,z;
		@w,@h,@d=w,h,d;
		@matrix=Matrix.identity(3);
	end
end

require('ui');
UI.debug=false;

UI.new.show(
	UI::Border.new(padding: 6).append(
		UI::Border.new.append(
			$view=UI::View.new(fps: 20)
		)
	)
);

box=Box3D.new();

# Define some convenience functions
def putz(x,y,z,c)
	# perspective translation
	x*=PERSPECTIVE**z;
	y*=PERSPECTIVE**z;

	# center
	x+=$w/2;
	y+=$h/2;

	$view.put(x,y,c);
end

$view.scene=->(){
	$w,$h=$view.wh;
	$view.clear;
	box.draw();
	box.rotateY(0.07);
	box.rotateX(0.01311);
	box.rotateZ(0.041247);
};

sleep;
