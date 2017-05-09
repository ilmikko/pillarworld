require("./console.rb");
require("./canvas.rb");
require("./noise.rb");
require("./input.rb");

$screen.sceneSet(
        ->(w,h){
                x,y=$canvas.xy;

                $screen.clear();

                $canvas.drawCircle(x,y,radius:500,char:".");

                $canvas.drawCircle(x+31,y-31,radius:15,char:"e");

                $canvas.plot(->(x,y,m){

                        return $noise.perlin(x/m,y/m)<0;

                        },x-55,y-15,50,50,char:':');

                $canvas.draw(0,0,char:"+");

                $canvas.draw(x,y,char:"X");

                $screen.write(w-1,h-1,"X:#{$canvas.x} Y:#{$canvas.y} Zoom:#{$canvas.zoom}",align:2);

                $screen.cursorSet(22,22);
        }
);

$input.listen(
        ->(char){
                $console.dump("KEY: #{char}");
                if (char=="+")
                        $canvas.zoom*=2.0;
                elsif (char=="-")
                        $canvas.zoom/=2.0;
                elsif (char=="h")
                        $canvas.x+=1/$canvas.zoom;
                elsif (char=="l")
                        $canvas.x-=1/$canvas.zoom;
                elsif (char=="k")
                        $canvas.y+=1/$canvas.zoom;
                elsif (char=="j")
                        $canvas.y-=1/$canvas.zoom;
                else
                        return false;
                end

                $screen.update=true;

                return true;
        }
);

$screen.render();

Kernel::sleep();
