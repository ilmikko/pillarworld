require_relative('../view');

w=10;
view=View.new(10,10,w,10);

view.scene=->{
	view.put(0,1,"This text should not clip");
	view.write(0,2,"But this text should clip");
	view.put(-7,3,"This text shouldn't show");
	view.write(-7,4,"But this text should show");
}

loop{
	view.clear;
	w+=1;
	view.width=w;
	view.x-=1;
	sleep 1;
}

sleep;
