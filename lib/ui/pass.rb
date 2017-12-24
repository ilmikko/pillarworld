#
# UIPass
# Has one children, passes everything to its child like it wasn't there at all.
# Inherited and used in modules like UIBorder.
#
class UI::Pass < UI::Array
	# Pass prevents more than 1 children to exist simultaneously.
	# This is to prevent headaches with overlapping elements (Pass doesn't know how to position them!)
	# You should have probably used a Flex instead.
	def append(*items)
		multierror = "Error: #{self.class} cannot contain multiple elements (tried to have #{items.length+@children.length}).";
		raise multierror if items.length+@children.length>1;
		super(*items);
	end
end
