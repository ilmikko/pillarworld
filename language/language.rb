# Mission: make a language generator. Something that sounds like a real language but isn't anything in particular.
# Have meanings for different words so it's not just gibberish. Combine everything in a logical structure.
# Let languages evolve over time.
# We can use my vimwiki to get a lot of words
#
# Let's create a rating system where we receive (randomly) generated words, and we can rate the best out of them to give a feedback loop to the generator.

require('../console.rb');
$console.echo=true;
$console.dump=false;

module Enumerable
	def sum
		self.inject(0){|accum, i| accum + i }
	end

	def average
		self.sum/self.length.to_f
	end

	def sample_variance
		m = self.average
		sum = self.inject(0){|accum, i| accum +(i-m)**2 }
		sum/(self.length - 1).to_f
	end

	def standard_deviation
		return Math.sqrt(self.sample_variance)
	end
end

$alphabet = "abcdefghijklmnopqrstuvwxyz".split(//);

class LanguageAlgorithm
	@@follows={};
	@@combinations={};
	@@wovels="aeiouy".split(//);
	@@valid_alphabet = $alphabet;
	def type;@type;end
	def initialize(type)
		@type=type;
	end
end

class LanguageAlgorithm_Random < LanguageAlgorithm
	def genWord()
		bitlength=(@bpw.average+(rand-0.5)*2*@bpw.standard_deviation);
		word='';
		if (bitlength.nan?) 
			$console.warn("#{self.type}: No words to choose from");
			return word;
		end
		$console.debug("Word bit length: #{bitlength}");
		for i in 0...bitlength
			word+=@bits.sample;
		end
		return word;
	end
	def learnWords(worddict)
		def splitWord(word)
			wovels="aeiouy".split(//);
			return word.split(Regexp.new("([#{wovels}])"));
		end

		worddict.each do |word,key|
			bits=splitWord(word);

			@bpw<<bits.length;

			bits.each do |bit|
				@bitdata[bit]=0 if !@bitdata.key?(bit);
				@bitdata[bit]+=1;
				@bits.push(bit);
			end
		end
		$console.log("#{@type}: #{@bitdata.keys.length} unique bits vs #{@bits.length} total");
		$console.log("#{@type}: Average bit length per word: #{@bpw.average}, stdev: #{@bpw.standard_deviation}");
	end
	def initialize()
		super("\e[031mRandom\e[0m");
		@bits=[];
		@bitdata={};
		@bpw=[]; # bits per word
	end
end

class LanguageAlgorithm_EvenOdd < LanguageAlgorithm
	def genWord()	
		bitlength=(@bpw.average+(rand-0.5)*2*@bpw.standard_deviation);
		word='';
		if (bitlength.nan?) 
			$console.warn("#{self.type}: No words to choose from");
			return word;
		end
		$console.debug("Word bit length: #{bitlength}");
		for i in 0...bitlength
			if i%2==0
				word+=@genwovels.sample;
			else
				word+=@genconsonants.sample;
			end
		end
		return word;
	end
	def learnWords(worddict)
		def splitWord(word)
			return word.split(Regexp.new("([#{@@wovels}]+)"));
		end

		worddict.each do |word,key|
			bits=splitWord(word);

			@bpw<<bits.length;

			bits.each do |bit|
				@bitdata[bit]=0 if !@bitdata.key?(bit);
				@bitdata[bit]+=1;
				if @@wovels.include?(bit[0])
					@genwovels.push(bit);
				else
					@genconsonants.push(bit);
				end
			end
		end
		$console.log("#{@type}: #{@bitdata.keys.length} unique bits");
		$console.log("#{@type}: Average bit length per word: #{@bpw.average}, stdev: #{@bpw.standard_deviation}");
	end
	def initialize()
		super("\e[034mEvenOdd\e[0m");
		@bpw=[];
		@bitdata={};
		@genwovels=[];
		@genconsonants=[];
	end
end

class LanguageAlgorithm_TrueLearner < LanguageAlgorithm
	# Learn connections between words
	# Attach a 'score' for word paths
	# There are no 'wovels' or 'consonants'
	def genWord()
		word='';
		
		length=1500;
		# for now, choose at random without taking score into consideration
		data=@@combinations;
		for i in 0..length
			if (data.keys.length==0)
				break;
			end
			# Sort our data by the score
			scoresorted=data.map{|k,v|{char:k,score:v[:score]}}.sort_by{|i| -i[:score]};

			$console.debug("#{@type}: choose: #{scoresorted}");

			char=scoresorted.sample[:char];
			data=data[char][:data];
			word+=char.to_s;
		end

		$console.log("#{@type}: word score: #{score(word)}");

		return word;
	end
	def score(word)
		bits=splitIntoBits(word);
		data=@@combinations;
		scores=[];
		bits.each{ |bit|
			if (data.keys.length==0)
				scores.push(0);
			end

			scores.push(data[bit][:score]);
			data=data[bit][:data];
		}
		return scores;
	end
	def splitIntoSymbols(word)
		return word.split(//);
	end

	def splitIntoBits(word)
		return word.split(//);
	end
	def learnWords(worddict)
		worddict.each do |word,score|
			symbols=splitIntoSymbols(word);

			follows=@@follows;

			#symbols.each do |symbol|
			#	follows[symbol]={}; if !follows.key?(symbol);
			#	follows[symbol][previoussymbol]=0; if !follows[symbol].key?(previoussymbol);
			#	follows[symbol][previoussymbol]+=1;
			#end

			bits=splitIntoBits(word);
			total_length=bits.length.to_f;
			newword=false;
			
			#while (bits.length>0)
				datas=[@@combinations];
				current_length=bits.length.to_f;

				for h in 0...bits.length
					bit=bits[h];
					for i in 0...datas.length
						data=datas[i];

						if !data.key? bit
							newword=true;
							data[bit]={score:0,data:{}};
						end

						data[bit][:score]+=(current_length/total_length)*score;
						data=datas[i]=data[bit][:data];

						if !data.key? bits[h+1]
							if (h!=0&&newword==false)
								newword=true;
								datas.push(@@combinations);
							end
						end
					end
				end
				bits.shift();
			#end
		end
	end
	def initialize()
		super("\e[035mTrueLearner\e[0m");
	end
end
$algorithms=[];
$algorithms.push(LanguageAlgorithm_Random.new());
$algorithms.push(LanguageAlgorithm_EvenOdd.new());
$algorithms.push(LanguageAlgorithm_TrueLearner.new());

# differentiate symbols from actual characters our language uses.
# $symbols="abcdefghijklmnopqrstuvwxyz".split(//);
# $consonants="bcdfghjklmnpqrstvwxz".split(//);
# $wovels="aeiouy".split(//);

def includeWordsFromFile(worddict,file)
	$console.log("Getting words from #{file}!");
	begin
		contents=File.read("#{file}");
	rescue => err
		$console.error(err);
		return worddict;
	end

	regex=Regexp.new('[^'+$alphabet.join('')+'\s\-]');
	$console.log("regex: #{regex}");
	words=contents.strip.downcase.gsub(regex,'').split(/\s+|-/);
	wordlen=words.length;
	$console.log("There are #{wordlen} words here.");
	words.each do |word|
		worddict[word]=0 if !worddict.key?(word);
		worddict[word]+=1;
	end
	dictlen=worddict.keys.length;
	$console.log("Unique words: #{dictlen}, removed #{wordlen-dictlen} duplicates.");
	return worddict;
end

def genWordEvenOdd(bits)
	bitlength=($bitlengthavg+(rand-0.5)*2*$bitlengthstdev);
	word='';
	$console.debug("Word bit length: #{bitlength}");
	for i in 0...bitlength
		word+=bits.sample;
	end
	return word;
end

$words={};
$words=includeWordsFromFile($words,'words.txt');
$words=includeWordsFromFile($words,'/home/iveks/vimwiki/BI1511/lectures.wiki');

# Let's set up some rules according to these words.
# Split them up to lil bits, by consonants and wovels!

$algorithms.each do |alg|
	alg.learnWords($words);
end

$console.info("Here we present to you");
gets();
while true
	$algorithms.each do |alg|
		for i in 0...4
			$console.info("#{alg.type}: #{alg.genWord()}");
		end
	end
	input=gets();
end

class Language
	def initialize()
	end
end

$language = Language.new()
