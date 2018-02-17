#
# A simple test that border works - just master but with border.
#

UI.new.show(
	UI::Border.new.append(
		UI::Text.new('Text in a border element')
	)
);
