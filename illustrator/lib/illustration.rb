class Illustration
	def self.load(path)
		filedata=File.read(path);
		return parse(filedata);
	end

	def self.parse(data)
		parser=Illustration::Parser.new;
		parsed=parser.parse(data);
		ill=Illustration.new(parsed.width,parsed.height);
		ill.characters=parsed.characters;
		ill.colors=parsed.colors;
		return ill;
	end

	attr_reader :width, :height
	attr_accessor :characters,:colors

	def each_cell
		# Loop through cells and print out colors and stuff
		len=@characters.length;
		
		w=@width;
		h=@height;

		characters=@characters.dup;
		colors=@colors.dup;

		for i in 0...len
			x=i % w;
			y=i / w;
			char=characters[i];
			col=colors[i];
			yield [x,y,col,char];
		end
	end

	def get_char(x,y)
		@characters[geti(x,y)];
	end

	def geti(x,y)
		w,h=@width,@height;
		# Get a specific cell's character
		i=(x % w)+(y * w);
	end

	def get_col(x,y)
		@colors[geti(x,y)];
	end
	
	def initialize(width,height)
		@width=width;
		@height=height;
		@characters=[];
		@colors=[];
	end
end

require 'illustration/parser';
