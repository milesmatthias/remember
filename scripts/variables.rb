#!/usr/bin/env ruby

# local, instance, class, class instance, etc.
# https://gist.github.com/milesmatthias/5f782c5ece015722eee0

def section_seperator
  puts <<EOF



=========================
=========================
EOF
end

def puts_answer(val)
  puts "  = " + val.to_s + "\n\n"
end

def puts_code(code_str)
  puts "\n\n****************"
  puts code_str
  puts "****************\n\n"
end


# Locals
puts "Local variables start with a lower case letter or an underscore and are scoped to a procedure or the entire script if a procedure is not defined:"
a = 42
puts "a = 42"
puts "puts a"
puts_answer a
section_seperator


# local variable scope in a proc
puts "Local variables are accesible to the innards of a proc wherever that proc is defined:"
_get_a = lambda { a }
puts "_get_a = lambda { a }"
puts "puts _get_a.call"
puts_answer _get_a.call
section_seperator

# instance variables
puts "Instance variables are private variables belonging to whatever object 'self' is:"
@a = 42
puts "@a = 42"
puts "puts @a"
puts_answer a
section_seperator

# class instance variables
puts "A class instance variable is a variable not passed to subclass instances of that class and only accessible to class methods:"
class A
  @x = 42

  def atx
    @x
  end

  def self.x
    @x
  end

  def x
    self.class.x
  end
end

class B < A
  def getx
    @x
  end
end

puts_code <<EOF
class A
  @x = 42

  def atx
    @x
  end

  def self.x
    @x
  end

  def x
    self.class.x
  end
end

class B < A
  def getx
    @x
  end
end

a = A.new
b = B.new
EOF

a = A.new
b = B.new

puts "puts A.instance_variables"
puts A.instance_variables
puts_answer A.instance_variables

puts "puts a.x"
puts_answer a.x

puts "puts a.atx.class"
puts_answer a.atx.class

puts "puts b.getx.class"
puts_answer b.getx.class
section_seperator


# Class variables
puts "Class variables can be read (not written) from the class object without using a class method. Subclass instances of the class receive the variable and affect all objects in the hierarchy when they change it:"

class A
  @@x = 42

  def self.get_x
    @@x
  end
end

puts_code <<EOF
class A
  @@x = 42

  def self.get_x
    @@x
  end
end
EOF

puts "puts A.x"
puts_answer A.x
puts "puts A.get_x"
puts_answer A.get_x

class B < A
end

puts_code <<EOF
class B < A
end
EOF

puts "puts B.x"
puts_answer B.x.class
puts "puts B.get_x"
puts_answer B.get_x

class C < B
  @@x = 24
end

puts_code <<EOF
class C < B
  @@x = 24
end
EOF

puts "puts C.x"
puts_answer C.x.class
puts "puts C.get_x"
puts_answer C.get_x

puts "puts B.x"
puts_answer B.x.class
puts "puts B.get_x"
puts_answer B.get_x

puts "puts A.x"
puts_answer A.x
puts "puts A.get_x"
puts_answer A.get_x

section_seperator


# constants
puts "Constants are immutable (but not really since you can get around it):"
X = 42

puts_code <<EOF
X = 42
EOF

puts "puts X"
puts_answer X

section_seperator

# global variable
puts "Global variables are accessible everywhere."

class A
  $x = 42
end

class B
  def self.get_global_x
    $x
  end
end

puts_code <<EOF
class A
  $x = 42
end

class B
  def self.get_global_x
    $x
  end
end
EOF

puts "puts B.get_global_x"
puts_answer B.get_global_x











