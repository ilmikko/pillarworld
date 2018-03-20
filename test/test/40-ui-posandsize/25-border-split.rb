#
# Uneven border splits
#

UI.new.show(
	UI::Split.new(width:99,height:33).append(
		UI::Border.new,
		UI::Border.new,
		UI::Border.new,
		UI::Border.new,
		UI::Border.new
	)
);
