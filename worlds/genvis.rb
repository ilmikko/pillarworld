Dir.chdir('../');
require('./console.rb');$console.echo=false;$console.file=true;

require('./time.rb');
require('./space.rb');
require('./canvas.rb');

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

$screen.sceneSet(
        ->(w,h){
                $screen.clear();

                $canvas.render($space);

                debug=[
                        "Gametime: #{$time.now}",
                        "Time delta: #{$time.delta}",
                        "Future: #{$time.future}",
                        "Active: #{$time.active}",
                        fmt($time.now)
                ];

                $screen.writeLines(w-1,h-1,debug,align:2);
        }
);

$input.listen({
        '.':->{$time.delta*=2.0;},
        ',':->{$time.delta/=2.0;},

        '+':->{$canvas.zoom*=2.0;},
        '-':->{$canvas.zoom/=2.0;},
        'h':->{$canvas.x-=1/$canvas.zoom;},
        'l':->{$canvas.x+=1/$canvas.zoom;},
        'k':->{$canvas.y-=1/$canvas.zoom;},
        'j':->{$canvas.y+=1/$canvas.zoom;}
});

def fmt(ms)
        seconds=(ms/1000).to_i;
        s="%02d" % (seconds%60);
        m="%02d" % ((seconds/60)%60);
        h="%02d" % ((seconds/60/60)%24);
        d=(seconds/60/60/24)%365;
        y=seconds/60/60/24/365;
        return "#{h}:#{m}:#{s} - Day #{d} Year #{y}";
end

def loop
        Pillar.new(position:VectorRandom.new(12).xy,events:{
                'end':->{
                        loop
                }
        });
end

loop

sleep
