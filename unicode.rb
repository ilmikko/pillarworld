$LOAD_PATH.push('./lib');

require('console');
require("./screen.rb");

require 'io/console';

$screen.clear();
$screen.cursorSet(0,0);

int=33;#0xE000;
w=$screen.width;

while true
        $stdout.write("\r\n");

        for g in 0..w
                int+=1;
                $stdout.write(int.chr("utf-8"));
        end


        # Pause until keypress
        pause=STDIN.getch;

	break if pause=="\u0003";
end

$screen.close();
