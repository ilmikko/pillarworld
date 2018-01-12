$LOAD_PATH.push('../lib');

require('console');

$LOAD_PATH.push('lib');

require('illustrator');

#illustration=Illustration.load('demo/illustration-saved.ifl');
#illustration=Illustration.load('demo/lava.ifl');

session=Illustrator.new();

session.load('test');

sleep;
