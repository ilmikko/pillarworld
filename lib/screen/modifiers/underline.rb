class Screen::Modifier::Underline < Screen::Modifier
	@@state_on=4; # Underline on
	@@state_off=24; # Underline off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
