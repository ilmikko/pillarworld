for y in 0..255
	for x in 0..255
		print("\e[38;2;#{x};#{y};255mT");
	end
	print("\r\n");
end
print("\r\n");
