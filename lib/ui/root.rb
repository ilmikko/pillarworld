class UI::Root < UI::Array
	def update
		$console.log("RESIZE TO #{@@view.wh}");
		self.change_xy=[0,0];
		self.change_wh=@@view.wh;
		self.change;
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
