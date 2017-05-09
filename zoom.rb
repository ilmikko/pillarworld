require("./console.rb");
require("./screen.rb");
require("./input.rb");

$zoom=1;
$x=0;
$y=0;

def zoomrender(w,h)

        $screen.clear();

        for sy in 0..h
                for sx in 0..w
                        ztest=((($x+sx-w/2)/$zoom)**2+(($y+sy-h/2)/$zoom)**2)/$zoom;
                        if (ztest<1&&ztest>0.5)
                                $screen.putc(sx,sy,"X");
                        end
                end
        end

        $screen.cursorSet(w,h);
        $screen.writeRight("X:#{$x} Y:#{$y} Zoom:#{$zoom}");
end
$screen.sceneSet(:zoomrender);

def zoomlistener(char)
        $console.dump("KEY: #{char}");
        if (char=="+")
                $zoom*=1.1;
        elsif (char=="-")
                $zoom/=1.1;
        elsif (char=="h")
                $x-=$zoom;
        elsif (char=="l")
                $x+=$zoom;
        elsif (char=="j")
                $y-=$zoom;
        elsif (char=="k")
                $y+=$zoom;
        else
                return false;
        end

        $screen.render();
        return true;
end
$input.listen(:zoomlistener);

def printchars(w,h)
        $screen.clear();
        $screen.cursorSet(w/2,h/2);
        $screen.writeCentered("this is a test "+0x2248.chr('UTF-8'));
end
#$screen.sceneSet(:printchars);

$screen.render();

Kernel::sleep();
