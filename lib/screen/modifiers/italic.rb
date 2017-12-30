class Screen::Modifier::Italic < Screen::Modifier
	@@state_on=3; # Italic on
	@@state_off=23; # Italic off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
