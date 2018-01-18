class UI::Root < UI::Array
	def update
		self.xy=[0,0];
		$console.log("RESIZE TO #{@@screen.wh}");
		self.resize_wh=@@screen.wh;
		change;
		@@screen.clear();
		redraw;
	end

	def initialize(screen)
		@parent=self;
		@@screen=screen;

		$console.log("Root screen is set as #{@@screen}");

		super();
	end
end
