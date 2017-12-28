require_relative('../view');

print("\e[32m");

screen=View.new;

screen.write(0,0,"This text should not have any modifiers");
screen.write(0,1,"This text should appear red.",color: Screen::Color[:red]);
screen.write(0,2,"This text should not have any modifiers");
screen.write(0,3,"This text should appear yellow.",color: Screen::Color[:yellow]);
screen.write(0,4,"This text should appear yellow as well.",color: Screen::Color[255,255,0]);
screen.write(0,5,"This text should be green and bold.",color: Screen::Color[:green],bold:true);
screen.write(0,6,"This text should be italic and blue.",italic:true,color: Screen::Color[0,0,255]);
screen.write(0,7,"This text should be bold and italic, but without any color.",bold:true,italic:true);

sleep;
