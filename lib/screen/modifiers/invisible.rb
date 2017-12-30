class Screen::Modifier::Invisible < Screen::Modifier
	@@state_on=8; # Invisible on
	@@state_off=28; # Invisible off

	def to_i
		@state ? @@state_on : @@state_off;
	end
end
