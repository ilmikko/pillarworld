# UI handler
require 'console';
require 'view';

class UI
	@@view=View.new;
	def self.view=(view)
		@@view=view;
	end
	def self.view;
		@@view;
	end

	@@debug=false;

	def self.debug=(v)
		@@debug=v;
	end
	def self.debug?
		!!@@debug
	end

	attr_reader :view;
	attr_reader :root;

	def clear;
		@view.clear;
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
	
	def initialize(view: @@view)
		@view=view;
		@root=UI::Root.new(@view);
		$console.log("#{self} is attaching resize event to #{@view}");
		@view.on('resize',->{
			$console.log("RESIZE STUFF");
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
