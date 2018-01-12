class Illustration::Parser
	attr_reader :width, :height
	attr_reader :characters, :colors

	def convert_ifl(ill)
		# This is a bit like an inverse 'parse'.
		data='';

		w,h=ill.wh;

		data+='IMILL '; # Magic
		data+="#{w}x#{h}"; # Size

		data+="\n"; # End headers

		# Rows of characters
		y_last=0;
		ill.each_cell{|x,y,col,char|
			if y!=y_last;
				data+="\n"; # Insert newlines when y changes
				y_last=y;
			end
			data+=char; # Insert char
		}

		data+="\n"; # End characters

		col_last=nil;
		same_cols=0;
		ill.each_cell{|x,y,col,char|
			col=col.rgb.join(',');
			if col==col_last
				same_cols+=1;
			else
				if same_cols>0
					# Increment skip
					data+=">#{same_cols}\n";
					same_cols=0;
				end
				data+="#{col}\n";
			end
			col_last=col;
		}

		# Add the last skip which is required for sanity check
		if same_cols>0
			data+=">#{same_cols}\n";
		end

		return data;
	end

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
							raise "Malformed columns in illustration, parsing failed. (#{x}!=#{@width})";
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
		if i==0
			raise "Malformed illustration: no colors set.";
		end
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
