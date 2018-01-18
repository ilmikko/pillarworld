# 
# A test for resizing ui elements once they have been created.
#
# A couple of notable examples are:
# A border with preferred size set to [1,1] gets that resized to [10,5], and as it lies inside a UI Stack it needs to 'push' all the other elements downwards.
# or
# A text element that has a dynamic text needs to be centered at all times. The text starts at HELLO and then becomes I AM EXCITED via `.text=`.
# This means, if the UIText is in a paragraph and its dimensions have changed, the parent element needs to recalculate all the children again.
#
# This could become a general rule: if a dimensions of a node change, we have to always redraw the parent / let the parent decide whether it needs a full redraw.
# This is done by the 'change' listener.
#
# FIXME: Triggering 'change' will always reposition the children regardless of if the reposition is actually needed. How do we check if it is needed or not?
# FIXME: Sometimes triggering a 'change' isn't enough if elements would need to grow further. Currently there is no 'grow', only a grow maximum.
# 			 For example, if I was to create a UIBorder with w:20 and h:20, and append a UIText that was 30 characters wide, the rest of the text would be cropped
# 			 because the size limit of Border is solid. In reality we might want UIBorder to expand along with its elements, i.e. set min and max widths.
#				 This might be a convention problem as well; you might say w:20 because you want the element to have a width of 20, but maybe you should think as a
#				 developer if you truly want the element to have a width of 20 _always_, or _just in this situation_. i.e. do you want the element to grow if it thinks
#				 it really needs to (because of the size of its children), or shrink if there is absolutely no space available? That's what responsive design is about,
#				 but it requires the developer to rethink what it really means to set a 'width of 20' for an element

require_relative('../ui');

ui=UI.new;
ui.show(
	UI::Stack.new.append(
		resizingelement=UI::Border.new(width: 4, height: 4).append(
			UI::Text.new('One text')
		),
		UI::Border.new(width: 10, height: 10).append(
			UI::Text.new('Two text')
		)
	)
);

sleep 1;

resizingelement.resize_wh=[10,5];
#ui.root.update;

sleep;
