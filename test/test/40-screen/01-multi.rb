# 
# Testing what happens if you have multiple screens
#

screen1=Screen.new;

w,h=screen1.wh;

screen1.put(0,0,'A');
screen1.put(w-1,0,'B');
screen1.put(0,h-1,'C');
screen1.put(w-1,h-1,'D');

# Should clear the screen and overwrite, as this is not a view

screen2=Screen.new;

screen2.put(1,1,'E');
screen2.put(w-2,1,'F');
screen2.put(1,h-2,'G');
screen2.put(w-2,h-2,'H');
