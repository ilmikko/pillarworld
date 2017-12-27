require_relative('../screen');

screen=Screen.new;

# First, raw way to change color
screen.put(1,2,"\e[mRaw colors (might change due to system palette) and high intensity colors (90-)");
print("\e[30m");
screen.put(1,3,"#");
print("\e[31m");
screen.put(2,3,"#");
print("\e[32m");
screen.put(3,3,"#");
print("\e[33m");
screen.put(4,3,"#");
print("\e[34m");
screen.put(5,3,"#");
print("\e[35m");
screen.put(6,3,"#");
print("\e[36m");
screen.put(7,3,"#");
print("\e[37m");
screen.put(8,3,"#");
#print("\e[0;30m");
#screen.put(9,3,"#");
#print("\e[31m");
#screen.put(10,3,"#");
#print("\e[32m");
#screen.put(11,3,"#");
#print("\e[33m");
#screen.put(12,3,"#");
#print("\e[34m");
#screen.put(13,3,"#");
#print("\e[35m");
#screen.put(14,3,"#");
#print("\e[36m");
#screen.put(15,3,"#");
#print("\e[37m");
#screen.put(16,3,"#");

# high intensity colors (non standard)
print("\e[90m");
screen.put(1,4,"#");
print("\e[91m");
screen.put(2,4,"#");
print("\e[92m");
screen.put(3,4,"#");
print("\e[93m");
screen.put(4,4,"#");
print("\e[94m");
screen.put(5,4,"#");
print("\e[95m");
screen.put(6,4,"#");
print("\e[96m");
screen.put(7,4,"#");
print("\e[97m");
screen.put(8,4,"#");

# Raw 256 color palette
screen.put(1,5,"\e[mRaw 256-colors (might change due to system palette)");
print("\e[38;5;0m");
screen.put(1,6,"#");
print("\e[38;5;9m");
screen.put(2,6,"#");
print("\e[38;5;10m");
screen.put(3,6,"#");
print("\e[38;5;11m");
screen.put(4,6,"#");
print("\e[38;5;12m");
screen.put(5,6,"#");
print("\e[38;5;13m");
screen.put(6,6,"#");
print("\e[38;5;14m");
screen.put(7,6,"#");
print("\e[38;5;15m");
screen.put(8,6,"#");

# Second, better way to change color

screen.put(1,8,"\e[mScreen colors, mapped the best way to the terminal");
screen.color=:black;
screen.put(1,9,"#");
screen.color=:red;
screen.put(2,9,"#");
screen.color=:green;
screen.put(3,9,"#");
screen.color=:yellow;
screen.put(4,9,"#");
screen.color=:blue;
screen.put(5,9,"#");
screen.color=:magenta;
screen.put(6,9,"#");
screen.color=:cyan;
screen.put(7,9,"#");
screen.color=:white;
screen.put(8,9,"#");

# Third, best way to change color

screen.put(1,11,"\e[mScreen colors, syntactical sugar");
screen.put(1,12,"#",color: Color[:black]);
screen.put(2,12,"#",color: Color[:red]);
screen.put(3,12,"#",color: Color[:green]);
screen.put(4,12,"#",color: Color[:yellow]);
screen.put(5,12,"#",color: Color[:blue]);
screen.put(6,12,"#",color: Color[:magenta]);
screen.put(7,12,"#",color: Color[:cyan]);
screen.put(8,12,"#",color: Color[:white]);

# custom colors

screen.put(1,14,"\e[mScreen colors, custom true color, reduced if necessary");
screen.put(1,15,"#",color: Color[0,0,0]);
screen.put(2,15,"#",color: Color[255,0,0]);
screen.put(3,15,"#",color: Color[0,255,0]);
screen.put(4,15,"#",color: Color[255,255,0]);
screen.put(5,15,"#",color: Color[0,0,255]);
screen.put(6,15,"#",color: Color[255,0,255]);
screen.put(7,15,"#",color: Color[0,255,255]);
screen.put(8,15,"#",color: Color[255,255,255]);

sleep;
