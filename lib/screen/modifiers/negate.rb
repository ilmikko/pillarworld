class Screen::Modifier::Negate < Screen::Modifier
	@@state_on=7; # Reverse video on
	@@state_off=27; # Reverse video off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
