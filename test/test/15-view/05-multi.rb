# 
# Test what happens with multiple views
#

# TODO: We don't want to be defining EVERY SINGLE STATE for EVERY SINGLE PUT CALL that there is. However, we need to do that at the moment, because
# we cannot cache a single view's set-state correspondence even if (realistically) the writes we do are only in a few set colors. This is because if
# you were to have a performance view and a regular view, where the regular view has a RED color state, when that redraws, it will set the SCREEN STATE
# to red and thus the performance view renders red as well.

view1=View.new(10,10);

w,h=view1.wh;

view1.put(0,0,'A');
view1.put(w-1,0,'B');
view1.put(0,h-1,'C');
view1.put(w-1,h-1,'D');

view2=View.new(10,10);

w,h=view2.wh;

view2.put(1,1,'E');
view2.put(w-2,1,'F');
view2.put(1,h-2,'G');
view2.put(w-2,h-2,'H');

sleep 0.5;

view2.clear;
