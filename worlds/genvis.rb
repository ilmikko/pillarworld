Dir.chdir('../');
require('./console.rb');$console.echo=false;$console.file=true;

require('./time.rb');
require('./space.rb');
require('./canvas.rb');

require("./noise.rb");

require('./input.rb');

# Several stages of generation to consider
# Each of these have their own "optimizations".
# For example, stage 0, or 'void stage', can be rendered as only dots and circles.

# Current stages in consideration:
# 0 - void
# 1 - pillar
# 2 - biome
# 3 - region
# 4 - town
# 5 - household
# 6 - person

# All of these stages are saved, or the information to generate these stages is saved.

def fmt(ms)
        seconds=(ms/1000).to_i;
        s="%02d" % (seconds%60);
        m="%02d" % ((seconds/60)%60);
        h="%02d" % ((seconds/60/60)%24);
        d=(seconds/60/60/24)%365;
        y=seconds/60/60/24/365;
        return "#{h}:#{m}:#{s} - Day #{d} Year #{y}";
end

def render
	#$canvas.clear();

	$canvas.render($space);

	debug=[
		"Gametime: #{$time.now}",
		"Time delta: #{$time.delta}",
		"Future: #{$time.future}",
		"Active: #{$time.active}",
		fmt($time.now),
		"M:#{$canvas.zoom},X:#{$canvas.x},Y:#{$canvas.y},Z:#{$canvas.z}"
	];

	$canvas.writeLines(w-1,h-1,debug,align:2);
end

$input.listen({
        # Time scale
        '.':->{$time.delta*=2.0;},
        ',':->{$time.delta/=2.0;},

        # Zoom
        '+':->{$canvas.zoom*=2.0;},
        '-':->{$canvas.zoom/=2.0;},

        # Vim-like navigation
        'k':->{$canvas.y-=1/$canvas.zoom;},
        'j':->{$canvas.y+=1/$canvas.zoom;},
        'l':->{$canvas.x+=1/$canvas.zoom;},
        'h':->{$canvas.x-=1/$canvas.zoom;},

        # Arrow keys
        "\e[A":->{$canvas.y-=1/$canvas.zoom;},
        "\e[B":->{$canvas.y+=1/$canvas.zoom;},
        "\e[C":->{$canvas.x+=1/$canvas.zoom;},
        "\e[D":->{$canvas.x-=1/$canvas.zoom;},

        # Page up / down for z
        "\e[5":->{$canvas.z+=1/$canvas.zoom;},
        "\e[6":->{$canvas.z-=1/$canvas.zoom;}
});

def loop
        pillar=Pillar.new(position:VectorRandom.new(22).xy,radius:5)
        pillar.on(:remove,->{
                loop
        });
end

loop

sleep
