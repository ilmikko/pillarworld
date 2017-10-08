# generate using a ruleset

class Language
	@@characters='01'.split(//);
	def translate(word)
		words=gets.strip.split(/\s+/);

		str=[];
		words.each{ |word|
			str.push(@words[word]);
		}
		return str.join(' ');
	end
	def initialize()
		@characters=@@characters;
		@words={};
	end
end

binary=Language.new;

puts('Translate English into binary!');
while true
	puts(binary.translate(gets));
end
