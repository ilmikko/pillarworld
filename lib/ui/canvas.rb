# 
# UICanvas
# An UI wrapper for Canvas - mostly for static images. See also: UIView
#

class UI::Canvas < UI::Node
	def write(*args)
		@@view.write(*args);
	end
end
