# UI handler
require 'console';
require 'canvas';

class UI
	attr_accessor :canvas;
	attr_accessor :root;

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
		@canvas=Canvas.new;
		@root=UI::Root.new(@canvas);
		@canvas.onresize(->{
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

require 'ui/root';
