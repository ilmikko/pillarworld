# A basic resizing test for a fullscreen view.

require_relative('../view');

view=View.new;
view2=View.new(20,20);

view.scene=->{
	w,h=view.wh;
	w-=1;
	h-=1;

	view.put(0,0,'A');
	view.put(w,0,'B');
	view.put(0,h,'C');
	view.put(w,h,'D');

	str='This text should be centered';
	view.put(w/2-str.length/2,h/2,str);
};

view2.scene=->{
	view2.put(2,2,'This text should be static at 2,2');
}

sleep;
