require("./console.rb");
require("./screen.rb");
require("./input.rb");

$zoom=1;
$x=0;
$y=0;

def zoomrender()
	w,h=$screen.dimensions;
        $screen.clear();

        for sy in 0..h
                for sx in 0..w
                        ztest=((($x+sx-w/2)/$zoom)**2+(($y+sy-h/2)/$zoom)**2)/$zoom;
                        if (ztest<1&&ztest>0.5)
                                $screen.put(sx,sy,"X");
                        end
                end
        end

        $screen.cursorSet(w,h);
        $screen.write(0,0,"X:#{$x} Y:#{$y} Zoom:#{$zoom}");
end

$input.listen({
	'+':->{
                $zoom*=1.1;
		zoomrender();
	},
	'-':->{
                $zoom/=1.1;
		zoomrender();
	},
	'h':->{
		$x-=$zoom;
		zoomrender();
	},
	'l':->{
		$x+=$zoom;
		zoomrender();
	},
	'j':->{
		$y-=$zoom;
		zoomrender();
	},
	'k':->{
		$y+=$zoom;
		zoomrender();
	}
});

def printchars(w,h)
        $screen.clear();
        $screen.cursorSet(w/2,h/2);
        $screen.writeCentered("this is a test "+0x2248.chr('UTF-8'));
end
#$screen.sceneSet(:printchars);

while true
	zoomrender();
	sleep(0.1);
end

Kernel::sleep();
