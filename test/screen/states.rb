# Screen state test

require_relative('../screen');

# Set screen to various colors before init

print("\e[31;3m");

y=0;

screen=Screen.new;

screen.put(1,y+=1,'This text should be the default screen color (not red)');

print("\e[33m");

greenboldstate=Screen::State.new(color:Screen::Color[:green], inverted:true);
bluestate=Screen::State.new(color:Screen::Color[0,0,255]);
italicstate=Screen::State.new(italic:true);
defaultstate=Screen::State.new;

$console.log("Italic state: #{italicstate}");

screen.put(1,y+=1,'This text should be yellow (not a state)');
bluestate.use;
screen.put(1,y+=1,'This text should be blue.');
italicstate.use;
screen.put(1,y+=1,'This text should be default color italic.');
greenboldstate.use;
screen.put(1,y+=1,'This text should be inverted green.');
defaultstate.use;
screen.put(1,y+=1,'This text should be default color.');
Screen::State.default.use;
screen.put(1,y+=1,'This text should be the screen default color (same as the first one).');

sleep;
