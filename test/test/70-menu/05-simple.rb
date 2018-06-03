# A simple menu test

menu=Menu.new.append(
	Menu::Item.new("Item 1"),
	Menu::Item.new("Item 2"),
	Menu::Item.new("Item 3"),
	Menu::Item.new("Item 4"),
	Menu::Item.new("Item 5"),
);
menu.focus; # Make menu active?
