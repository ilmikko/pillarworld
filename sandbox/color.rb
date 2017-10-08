require('./canvas.rb');
require('./input.rb');

$screen.put(100,0,"This text is supposed to be default color.");
$screen.put(100,1,"\e[033mThis text is supposed to be colored yellow.\e[0m");
$screen.put(100,2,"This text is supposed to be default color again.");
$screen.put(100,3,"\e[032mMore colors\e[0m");
$screen.put(100,4,"\e[034mMore colors\e[0m");
$screen.put(100,5,"\e[035mMore colors\e[0m");
$screen.put(100,6,"\e[036mMore colors\e[0m");

$canvas.draw(0,0,"This text is supposed to be default color.");
$canvas.draw(0,1,"This text is supposed to be colored yellow.",color:"\e[033m");
$canvas.draw(0,2,"This text is supposed to be default color again.");
$canvas.draw(0,3,"More colors",color:"\e[032m");
$canvas.draw(0,4,"More colors",color:"\e[034m");
$canvas.draw(0,5,"More colors",color:"\e[035m");
$canvas.draw(0,6,"More colors",color:"\e[036m");

sleep;
