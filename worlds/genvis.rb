Dir.chdir('../');
require('./console.rb');$console.echo=false;$console.file=true;

require("./time.rb");

require("./input.rb");
require("./canvas.rb");

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

seed=12345;

prng=Random.new(seed);

$screen.sceneSet(
        ->(w,h){
                $screen.clear();

                active=$time.active();
                time=$time.now;

                debug=[
                        "Gametime: #{time}",
                        "Active blocks: #{active}",
                        fmt(time)
                        ];

                $screen.writeLines(0,h-1,debug,align:0);
        }
);

$input.listen({
        '+':->{$time.delta*=2;},
        '-':->{$time.delta/=2;}
});

def fmt(ms)
        seconds=ms/1000;
        s="%02d" % (seconds%60);
        m="%02d" % ((seconds/60)%60);
        h="%02d" % ((seconds/60/60)%24);
        d=(seconds/60/60/24)%365;
        y=seconds/60/60/24/365;
        return "#{h}:#{m}:#{s} - Day #{d} Year #{y}";
end

$testBlock=$time.newblock(10000,90000,name:"Test block 1");
$time.newblock(11000,11000,name:"1");
$time.newblock(12000,11000,name:"2");
$time.newblock(13000,11000,name:"3");
$time.newblock(14000,11000,name:"4");
$time.newblock(15000,5000,name:"5");
$time.newblock(16000,11000,name:"6");

sleep
