Dir.chdir('../');
require('./console.rb');$console.echo=true;$console.file=false;
require('./random.rb');
require('json');

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

# Stage 0 gen
