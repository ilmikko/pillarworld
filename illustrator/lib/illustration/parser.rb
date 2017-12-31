class Illustration::Parser
	attr_reader :width, :height
	attr_reader :characters, :colors

	def parse(data)
		parsing=:header;
		x=0;
		y=0;
		w=nil;
		h=nil;
		i=0;

		data.each_line{|line|
			if parsing==:header
				$console.log('Parsing headers');
				raise "The file doesn't appear to be an illustration file, parsing failed." if !line.start_with? 'IMILL';
				line=line.split(' ');
				w,h=line[1].split('x');
				@width=w.to_i;
				@height=h.to_i;
				$console.log("Illustration: w:#{@width} h:#{@height}");
				y=0;
				parsing=:characters;
				$console.log('Parsing characters');
			elsif parsing==:characters
				y+=1;
				x=0;
				line.each_char{|char|
					ord=char.ord;
					if ord==10 # enter
						if x!=@width
							raise "Malformed columns in illustration, parsing failed.";
						end
						x=0;
					else
						@characters << char;
						x+=1;
					end
				}
				if y==@height
					$console.log('Characters parsed');
					$console.log('Parsing colors');
					parsing=:colors;
					i=0;
				end
			elsif parsing==:colors
				if line.start_with? '>'
					# skip some indices
					skip=line[1..-1].to_i;
					@colors += [@colors[i-1]]*skip;
					i+=skip;
				else
					i+=1;
					@colors << Screen::Color[*line.split(',').map{|s|s.to_i;}];
				end
			end
		}
		if i!=@width*@height
			raise "Malformed illustration (#{i}!=#{@width*@height}), parsing failed.";
		end
		if @characters.length!=@colors.length or @characters.length!=@width*@height;
			raise "Malformed characters or colors: #{@characters.length}!=#{@colors.length} (!=#{@width*@height}/#{i})"
		end

		return self;
	end
	def initialize
		@characters=[];
		@colors=[];
	end
end
