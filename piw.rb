require("./console.rb");
require("./screen.rb");

$screen.cursorSet(1,0);

$screen.sceneSet(lambda {|w,h|
                $screen.clear();
                $screen.cursorSet(1,0);
                $screen.write("So it begins.");
                $screen.cursorSet(w/2,h/2);
                $screen.writeCentered("The screen width is #{w}, and height is #{h}.");
                $screen.cursorSet(w/2,h/2+1);
                $screen.writeCentered("The console output is From My Anus");
        });

$screen.render();

Kernel::sleep();
