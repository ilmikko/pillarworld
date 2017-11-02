# Just a class inheritance test, realized that this is probably not going to be worth it.

class PhysicalObject
	def initialize
		@shape=:round;
	end
end

class LivingBeing < PhysicalObject
	def alive?;true;end
	def initialize
		super();
		@lifetime=10;
	end
end

class Animal < LivingBeing
	def legCount;@legs;end
	def initialize(legs: 4)
		super();
		@legs=legs;
	end
end

class Cat < Animal
	def initialize
		super(legs:4);
	end
end

$cat=Cat.new;

puts($cat.legCount<5);
