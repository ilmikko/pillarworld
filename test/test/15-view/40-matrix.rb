require('matrix');

class Box
	def xyz
		[@x,@y,@z];
	end
	def whd
		[@w,@h,@d];
	end
	def matrix
		@matrix
	end
	def rotateX(deg)
		@matrix*=Matrix[[1,0,0],[0,Math.cos(deg),Math.sin(deg)],[0,-Math.sin(deg),Math.cos(deg)]];
	end
	def rotateY(deg)
		@matrix*=Matrix[[Math.cos(deg),0,Math.sin(deg)],[0,1,0],[-Math.sin(deg),0,Math.cos(deg)]];
	end
	def rotateZ(deg)
		@matrix*=Matrix[[Math.cos(deg),-Math.sin(deg),0],[Math.sin(deg),Math.cos(deg),0],[0,0,1]];
	end
	def initialize(x:0,y:0,z:0,w:10,h:10,d:10)
		@x,@y,@z=x,y,z;
		@w,@h,@d=w,h,d;
		@matrix=Matrix.identity(3);
	end
end

class MatrixTest
	def putc(x,y,z,c)
		w,h=@view.wh;
		# perspective translation
		x*=@perspective**z;
		y*=@perspective**z;

		x+=w/2;
		y+=h/2;

		@view.put(x,y,c);
	end
	def put(box,x,y,z,c)
		selfmatrix=Matrix[[x],[y],[z]];
		transform=box.matrix*selfmatrix;

		x=transform[0,0]
		y=transform[1,0]
		z=transform[2,0]

		## Debug
		#puts(transform)
		#puts("X: #{x}, Y: #{y}, Z: #{z}")
		#sleep(1)
		putc(x,y,z,c);
	end
	def draw(box)
		x,y,z=box.xyz;
		w,h,d=box.whd;

		put(box,x-w/2,y-h/2,z-d/2,'1')
		put(box,x-w/2,y-h/2,z+d/2,'9')
		put(box,x+w/2,y-h/2,z-d/2,'2')
		put(box,x+w/2,y-h/2,z+d/2,'8')
		put(box,x-w/2,y+h/2,z-d/2,'3')
		put(box,x-w/2,y+h/2,z+d/2,'7')
		put(box,x+w/2,y+h/2,z-d/2,'4')
		put(box,x+w/2,y+h/2,z+d/2,'6')

		put(box,x,y,z,'X');
	end
	def initialize
		@screen=Screen.new;
		@view=View::Performance.new(90,30,screen:@screen,fps:60);
		@view2=View.new(90,20,y:30,screen:@screen);

		@view2.scene=->(){
			$console.log("Redrawing scene2");
			@view2.put(0,0,"Hello World!");
		};

		@perspective=1.1;
		@box=Box.new#(w:$screen.width/10,h:$screen.height/10);

		@view.scene=->{
			d=0.03;
			@view.clear;
			draw(@box);
			@box.rotateX(0.03);
			@box.rotateZ(0.004);
		};
	end
	def destroy
		@view.destroy;
		@view2.destroy;
	end
end

matrix=MatrixTest.new;

sleep [1, $interval].max;

$console.log("End test!");
matrix.destroy();
