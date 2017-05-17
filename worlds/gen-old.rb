Dir.chdir('../');
require('./console.rb');

# Generate a world for PillarWorld

# A world consists of several steps.
require('json');

$console.echo=true;

# SEED - the worlds that arise from one seed should ALWAYS be the same
# Every RNG in the game will be rooted to this seed.
worldseed = 12345;

$console.info("Master world seed: #{worldseed}");
mstrr = Random.new(worldseed);

# Then we will generate the 3D random value grid for the whole level. (perlin)
# Currently the grid is a box because I don't want to overly complicate things. (should be cylinder, reduces save file size)
# Every nth grid point gets a value
worldradius=50;
worldheight=100;

rvres=4; # every nth cell gets a random value
$console.info("RV resolution = #{rvres}");

world={};
rvgrid={};
$console.log("Initializing grids...");
for z in 0..worldheight
        world[z]={};

        rvz=z/rvres;
        rvgrid[rvz]={};
        for y in -worldradius..worldradius
                world[z][y]={};

                rvy=y/rvres;
                rvgrid[rvz][rvy]={};
                for x in -worldradius..worldradius
                        world[z][y][x]=0;

                        rvx=x/rvres;
                        rvgrid[rvz][rvy][rvx]={x:0,y:0,z:0};
                end
        end
end

$console.log("Populating grids...");
# Simulate world creation and change gradient in Matter flow when the Beam is fired
for z in 0..worldheight
        for y in -worldradius..worldradius
                for x in -worldradius..worldradius

                        if (x%rvres==0&&y%rvres==0&&x%rvres==0)
                                rvz=z/rvres;
                                rvy=y/rvres;
                                rvx=x/rvres;

                                #$console.debug("RV point @ #{z},#{y},#{x} -> #{rvz},#{rvy},#{rvx}");
                                rvgrid[rvz][rvy][rvx]=[];
                                srand();
                                rvgrid[rvz][rvy][rvx].push(mstrr.rand());
                                srand();
                                rvgrid[rvz][rvy][rvx].push(mstrr.rand());
                                srand();
                                rvgrid[rvz][rvy][rvx].push(mstrr.rand());
                        end

                        world[z][y][x]=255*mstrr.rand(); # pure material = 255, pure void = 0
                end
        end
end

iterations=100;
timedelta=1; # How fast the simulation should run - larger values mean less accuracy in short term happenings.
$console.info("Running simulation (td=#{timedelta})...");

time=0;
for i in 0..iterations
        $console.log("Iteration #{i}...");
        # TODO
        time+=iterations*timedelta;
end

$console.info("World generation complete!");

# SAVE
$console.info("Saving world #{worldseed}...");
Dir.mkdir("./worlds/#{worldseed}") unless File.exists?("./worlds/#{worldseed}");
$console.log("world.json...");
File.open("./worlds/#{worldseed}/world.json","w+") { |f|
        f.write(world.to_json);
        };
$console.log("rv.json...");
File.open("./worlds/#{worldseed}/rv.json","w+") { |f|
        f.write(rvgrid.to_json);
        };
$console.log("info.json...");
File.open("./worlds/#{worldseed}/info.json","w+") { |f|
        f.write({seed:worldseed,time:time,rvres:rvres}.to_json);
        };
$console.info("World saved!");
