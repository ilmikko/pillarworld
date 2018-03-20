#
# Block color test
# TODO
#

UI.new.show(
	UI::Stack.new.append(
		UI::Block.new(color: :red),
		UI::Block.new(color: :green),
		UI::Block.new(color: :blue)
	)
);
