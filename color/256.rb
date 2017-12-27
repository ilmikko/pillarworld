def rgbcol(r,g,b)
	throw "r,g,b (#{[r,g,b]}) need to be in range 0..5" if r<0 or g<0 or b<0 or r>5 or g>5 or b>5;
	return 16 + r*36+g*6+b;
end

def truergb(r,g,b)
	throw "r,g,b need to be in range 0..255" if r<0 or g<0 or b<0 or r>255 or g>255 or b>255;
	r/=51;
	g/=51;
	b/=51;
	return 16 + r*36+g*6+b;
end

def cycle(r,g,b)
	i = r*36+g*6+b+1;
	[(i/36)%6,(i/6)%6,i%6]
end

for i in -24...0
	print("\e[38;5;#{(i%255+1)}mxxx\e[m");
end

print("\r\n");
r=g=b=0;
for i in 0...24
	r=g=b=i/4;
	print("\e[38;5;#{rgbcol(r,g,b)}m#{r}#{g}#{b}\e[0m");
end

print("\r\n");

r=g=b=0;
for j in 0..5
	r=0;
	for h in 0..5
		b=0;
		for i in 0..5
			print("\e[38;5;#{rgbcol(r,g,b)}m#{r}#{g}#{b}\e[0m");
			b+=1;
		end
		r+=1;
	end
	print("\r\n");
	r,g,b=cycle(r,g,b);
end
