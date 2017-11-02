# Mission: Generate a wide variety of languages using a ruleset
#
# Questions to answer (rules)
# Punctuation? Does it have the same or different meaning?
# Likeness of upper/lowercase characters? (a=A, p=P, o=O)?
# Length of words? Influenced by usage?
# Similarity between two words accompanied by real world examples? (i.e. generating words based on the real (virtual) world?)
# Can we generate 'similar' words?
# Word pronunciation, some words impossible to say?

#class Console
#	def log(a)
#		@log.push("#{caller[0]}: #{a}");
#	end
#	def initialize
#		@log=[];
#		Thread.new{
#			while true
#				# filter log and display relevant messages
#				while @log.length>0
#					#puts(@log.shift);
#				end
#				sleep 1;
#			end
#		}
#	end
#end
#$console=Console.new;

# TODO: under construction

class Language
	@@default_characters='01'.split(//);
	def generateBogusWord(word)
		length=5;

		#$console.log('abc');

		bogusWord='';
		i=0;
		while true
			i+=1;
			bogusWord<<@characters.sample;
			break if (i>=length and !@words.key? bogusWord);
		end

		#$console.log("Word length overflowing: #{i}>#{length}") if i>length;
		@words[bogusWord]=true;

		return bogusWord;
	end
	def meaning?(word)
		@meanings.key?word;
	end
	def translateWord(word)
		@meanings[word]=generateBogusWord(word) if !meaning?(word);
		return @meanings[word];
	end
	def translate(sentence)
		words=sentence.upcase.strip.split(/\s+/);

		str=[];
		words.each{ |word|
			str.push(translateWord(word));
		}
		return str.join(' ');
	end
	def initialize(characters: @@default_characters)
		@characters=characters;
		@meanings={};
		@words={};
	end
end

binary=Language.new;

puts('Translate words into binary!');
while true
	puts(binary.translate(gets));
end
