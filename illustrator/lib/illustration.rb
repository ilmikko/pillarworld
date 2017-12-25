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

		for i in 0...len
			x=i % w;
			y=i / w;
			char=@characters[i];
			col='';
			col=@colors[i].map{|c|"\e[#{c}m"}.join if !@colors[i].nil?;
			yield [x,y,col+char];
		end
	end
	
	def initialize(width,height)
		@width=width;
		@height=height;
		@characters=[];
		@colors=[];
	end
end

require 'illustration/parser';
