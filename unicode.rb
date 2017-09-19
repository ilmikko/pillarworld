require("./console.rb");
require("./screen.rb");

require 'io/console';

$screen.clear();
$screen.cursorSet(0,0);

int=33;#0xE000;
w=$screen.width;

while true
        $screen.write("\r\n");

        for g in 0..w
                int+=1;
                $screen.write(int.chr("utf-8"));
        end


        # Pause until keypress
        STDIN.getch;
end

$screen.close();
