#
# Menu handler. Makes sure the focus is only on one element.
# Standard menu functionality.
#

class Menu
	attr_accessor :element;

	def focus
		self;
	end

	def append(*items)
		@element.append(*items.map{ |i| i.element; });

		self;
	end

	def show
		@ui.show(@element);

		self;
	end

	#######
	private
	#######
	
	def initialize(ui: UI.new)
		@ui=ui;
		@element=UI::Stack.new;
	end
end

require 'menu/item';
