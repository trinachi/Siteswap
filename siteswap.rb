require 'rubygems'
require 'backports'

class Siteswap
  def initialize(pattern_length, objects)
    @pattern_length = pattern_length
    @objects = objects
  end
  
  def start
    puts "Number of objects:"
    @objects = gets.chomp.to_i
    puts "Pattern length:"
    @pattern_length = gets.chomp.to_i
    puts valid_patterns.map {|x| x.to_s }
  end
  
  def patterns
    throws = (1..6).to_a
    patterns = throws.repeated_permutation(@pattern_length).to_a
    return patterns
  end
  
  def valid_patterns
    patterns.inject([]) { |acc, current|
      sum = sum(current)
      acc << current if is_valid?(current, sum)
      acc
    }
  end

  def is_valid?(current, sum)
    correct_number?(sum) && 
    good_first_throw(current) && 
    correct_timing(current) == true &&
    does_not_repeat(current)
  end
  
  def correct_number?(number)
    number/@pattern_length == @objects && number % @pattern_length == 0
  end

  def sum(sequence)
    sequence.reduce { |sum, x| sum + x } 
  end
  
  def good_first_throw(current)
    current[0] > 2
  end
  
  def does_not_repeat(current)
    current.delete_if { current.min == current.max }
    # should delete patterns like 3131 and 423423 and 313131. However, 31313X is fine
  end

  def correct_timing(current)
    double = current*2
    length = double.length - 1
    (0..(length - 1)).each do |x|
      ((x+1)..length).each do |y| 
        return false if y-x == double[x]-double[y]
      end
    end
    return true
  end
end

