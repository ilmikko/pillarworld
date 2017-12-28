class Screen::Modifier
	def self.bold
		"\e[1m";
	end
	def self.faint
		"\e[2m";
	end
	def self.italic
		"\e[3m";
	end
	def self.underline
		"\e[4m";
	end
	def self.negate
		"\e[7m";
	end
end
