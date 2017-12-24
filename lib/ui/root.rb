class UI::Root < UI::Array
	def update
		self.xywh=[0,0,*@@screen.wh];
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
