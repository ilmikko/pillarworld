#
# Testing what happens if you have multiple screens
#

require_relative('../screen');

screen1=Screen.new;

w,h=screen1.wh;

screen1.put(0,0,'A');
screen1.put(w-1,0,'B');
screen1.put(0,h-1,'C');
screen1.put(w-1,h-1,'D');

screen2=Screen.new;

w,h=screen2.wh;

screen2.put(1,1,'E');
screen2.put(w-1-1,1,'F');
screen2.put(1,h-1-1,'G');
screen2.put(w-1-1,h-1-1,'H');

sleep;
