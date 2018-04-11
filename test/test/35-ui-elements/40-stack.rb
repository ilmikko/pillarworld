#
# UI::Stack and element wrap test
#

class UI::Wrap < UI::Border
	def initialize
		super(grow:0);
	end
end

UI.new.show(
	UI::Stack.new(direction: :col).append(
		UI::Wrap.new.append(
			UI::Text.new("This")
		),
		UI::Border.new(grow:0).append(
			UI::Text.new("is")
		),
		UI::Text.new("text")
	)
);
