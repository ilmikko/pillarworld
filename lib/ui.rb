# UI handler
require 'console';
require 'screen';

class UI
	attr_reader :screen;
	attr_reader :root;

	@@debug=false;

	def self.debug=(v)
		@@debug=v;
	end

	def self.debug?
		!!@@debug
	end

	def show(*elems)
		$console.debug("UI: Show: #{elems}");
		@root.empty;
		@root.append(*elems);
		$console.log("Elements appended");
		@root.update;
	end

	#######
	private
	#######
	
	def initialize
		@screen=::Screen.new;
		@root=UI::Root.new(@screen);
		@screen.onresize(->{
			@root.update;
		});
	end
end

require 'ui/node';
require 'ui/array';
require 'ui/align';
require 'ui/stack';
require 'ui/flex';
require 'ui/text';
require 'ui/textline';
require 'ui/textarea';
require 'ui/pass';
require 'ui/padding';
require 'ui/border';
require 'ui/paragraph';

require 'ui/view';
require 'ui/canvas';

require 'ui/root';
