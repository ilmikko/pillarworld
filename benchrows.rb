require("./console.rb");
require("./canvas.rb");
require("./input.rb");

$screen.sceneSet(
        lambda { |w,h|
                $screen.clear();

                for y in 0..h
                        $screen.putc(0,y,"+"*w);
                end

                #for y in 0..h
                #        for x in 0..w
                #                $screen.putc(x,y,"+");
                #        end
                #end

                #$canvas.drawDebugInfo();
        }
);

$input.listen(
        lambda { |char|
                $screen.render();
                return true;
        }
);

$screen.render();

Kernel::sleep();
