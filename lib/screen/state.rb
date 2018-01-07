class Screen::State
	attr_accessor :color,:background,:bold,:faint,:italic,:inverted,:underline;

	def use
		str=to_s;
		$console.log("NEW STATE: #{str}");
		print(str);
	end

	def to_s
		# TODO: calculate state difference to current state
		# For example, if we have a state RED, BOLD, ITALIC
		# and we change to RED, BOLD, ITALIC, UNDERLINE
		# we can only print UNDERLINE because everything else is implied.
		a=@modifiers.values;
		a << @color if @color;
		a << @background if @background;
		str="\e[0;#{a.join(';')}m";
		return str;
	end

	#######
	private
	#######

	def initialize(color:nil,background:nil,**modifiers)
		@color=color if !color.nil?;
		@background=background if !background.nil?;
		#@modifiers={
		#	bold: Screen::Modifier.bold(modifiers[:bold]),
		#	faint: Screen::Modifier.faint(modifiers[:faint]),
		#	italic: Screen::Modifier.italic(modifiers[:italic]),
		#	negate: Screen::Modifier.negate(modifiers[:negate]),
		#	underline: Screen::Modifier.underline(modifiers[:underline]),
		#	invisible: Screen::Modifier.invisible(modifiers[:invisible])
		#};
		
		@modifiers=modifiers.map{|mod,bool|
			$console.log("Modifiers: #{mod} -> #{bool}");
			[mod,Screen::Modifier.public_send(mod,bool)];
		}.to_h;
	end
end

class Screen::State
	@@default=Screen::State.new(color:Screen::Color[:white],background:Screen::Background[:black]);
	def self.default;@@default;end
end
