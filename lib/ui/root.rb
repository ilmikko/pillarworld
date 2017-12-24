class UI::Root < UI::Array
	def update
		self.xywh=[0,0,*@@canvas.wh];
		change;
		@@canvas.clear();
		redraw;
	end

	def initialize(canvas)
		@parent=self;
		@@canvas=canvas;

		$console.log("Root canvas is set as #{@@canvas}");

		super();
	end
end
