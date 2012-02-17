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
    throws = (0..6).to_a
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
    correct_timing(current) &&
    Siteswap.repeat?(current) == false
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

  def self.repeat?(current)
    return true if current.uniq.length == 1 && current.length > 1
    length = current.length
    (2..length).each do |x|
      if length%x == 0 && length/x >= 2
        slices = []
        current.each_slice(x) {|a| slices << a }
        return true if slices.uniq.length == 1
      end
    end
    return false
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

