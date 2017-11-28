# UI handler
require_relative('../console.rb');
require_relative('canvas');

require_relative('ui-node');
require_relative('ui-text');
require_relative('ui-array');
require_relative('ui-pass');
require_relative('ui-align');
require_relative('ui-padding');
require_relative('ui-border');
require_relative('ui-paragraph');
require_relative('ui-textarea');
require_relative('ui-flex');

class UI < UIArray
	def update
		reflow;
		@@canvas.clear();
		redraw;
	end

	def reflow()
		self.xywh=[0,0,*@@canvas.wh];
		self.change;
	end

	def show(*elems)
		$console.debug("UI: Show: #{elems}");
		empty;
		append(*elems);
		$console.log("Elements appended");
		update;
	end

	def initialize()
		@parent=self;

		# Canvas gets set
		$console.log("Canvas is set");

		self.canvas=Canvas.new;

		super();

		@@canvas.onresize(->{
			update;
		});
	end
end

$ui=UI.new();
