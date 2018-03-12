#
# A slightly more complex view resize test
# TODO: Incorporate matrix to this
#

# FIXME: What if we want a bordered view, but control the size of the view only? i.e. the border should resize to wrap the view?

UI.new.show(
	UI::Align.new.append(
		UI::Border.new.append(
			view=UI::View.new(width:30,height:15)
		)
	)
);

view.scene=->{
	w,h=view.wh;
	view.put(0,0,'A');
	view.put(w-1,0,'B');
	view.put(0,h-1,'C');
	view.put(w-1,h-1,'D');
}
