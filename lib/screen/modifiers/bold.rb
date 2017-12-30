class Screen::Modifier::Bold < Screen::Modifier
	@@state_on=1; # Bold on
	@@state_off=22; # Bold off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
