require('../console.rb');
require('./canvas.rb');

canvas=Canvas.new;
canvas.hline(1,1,5);
canvas.hline(1,2,-1);
canvas.hline(canvas.width/2,0,-3);
canvas.hline(canvas.width/2,1,-2);
canvas.hline(canvas.width/2,2,-1);
canvas.hline(canvas.width/2,3,0);
canvas.hline(canvas.width/2,4,1);
canvas.hline(canvas.width/2,5,2);
canvas.hline(canvas.width/2,6,3);

sleep;
