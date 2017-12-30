class Screen::Modifier::Faint < Screen::Modifier
	@@state_on=2; # Faint on
	@@state_off=22; # Faint off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
