#
# Stacked text border elements
#

class UI::Wrap < UI::Border
	def initialize
		super(grow:0);
	end
end

UI.new.show(
	UI::Align.new.append(
		UI::Stack.new(direction: :row).append(
			UI::Wrap.new.append(
				UI::Text.new('This is a text 2')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text 3')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text 4')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text notice meeeeee I\'m different!')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text')
			),
			UI::Wrap.new.append(
				UI::Text.new('This is a text')
			)
		)
	)
);