#
# Menu item component
#

class Menu::Item
	attr_accessor :element;

	#######
	private
	#######

	def initialize(text)
		@element=UI::Text.new(text);
	end
end
