require('./console.rb');
require('./canvas.rb');
require('./input.rb');

$console.file=true;

$teee=0;

$canvas.sceneSet(
        ->(w,h){
                $teee+=1;
                $canvas.puts(2,2,"#{$teee}");
                $canvas.puts(2,3,'This text should be green',color:"\e[32m");
                $canvas.puts(2,4,"#{$teee}");
                $canvas.puts(2,5,'This text should be yellow',color:"\e[33m");
                $canvas.puts(2,6,"#{$teee}");
                $canvas.puts(2,7,'Heres some blue for ya '+$teee.to_s,color:"\e[34m");

                #time=(Time.now.to_f*1000).to_i;

                #c = ((time % 2)==0) ? '!' : '?';

                #c*=w;

                #for x in 0..w
                #        for y in 1..h
                #                #$stdout.write("\033["+y.to_s+';'+x.to_s+'H!');
                #                $screen.put(x,y,c);
                #        end
                #end

                #for y in 1..h
                        #$stdout.write("\033["+y.to_s+';'+x.to_s+'H!');
                #        $screen.put(0,y,c);
                #end
        }
);

$input.listen({
        'd':->{
                $canvas.drawDebugInfo();
        }
});

sleep
