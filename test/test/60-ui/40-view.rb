#
# UI View test
#

UI.new.show(
	view=UI::View.new
);

view.scene=->{
	w,h=view.wh;
	view.put(0,0,'A');
	view.put(w-1,0,'B');
	view.put(0,h-1,'C');
	view.put(w-1,h-1,'D');
}
