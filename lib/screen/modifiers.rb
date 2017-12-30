class Screen::Modifier
	def self.bold(state=true)
		Screen::Modifier::Bold.new(state);
	end
	def self.faint(state=true)
		Screen::Modifier::Faint.new(state);
	end
	def self.italic(state=true)
		Screen::Modifier::Italic.new(state);
	end
	def self.underline(state=true)
		Screen::Modifier::Underline.new(state);
	end
	def self.negate(state=true)
		Screen::Modifier::Negate.new(state);
	end
	def self.invisible(state=true)
		Screen::Modifier::Invisible.new(state);
	end

	attr_accessor :state;

	def to_s
		"#{to_i}";
	end

	def initialize(state=true)
		@state=state;
	end
end

require('screen/modifiers/bold');
require('screen/modifiers/faint');
require('screen/modifiers/italic');
require('screen/modifiers/underline');
require('screen/modifiers/negate');
require('screen/modifiers/invisible');
