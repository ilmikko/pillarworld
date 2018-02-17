class UI::Root < UI::Array
	def update
		self.xy=[0,0];
		$console.log("RESIZE TO #{@@view.wh}");
		self.resize_wh=@@view.wh;
		change;
		@@view.clear();
		redraw;
	end

	def initialize(view)
		@parent=self;
		@@view=view;

		$console.log("Root view is set as #{@@view}");

		super();
	end
end
