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
    puts "Required sequence:"
    @required_sequence = gets.chomp.to_s
    puts "Excluded sequence:"
    @excluded_sequence = gets.chomp.to_s
    puts "Patterns:"
    puts valid_patterns.map {|x| x.to_s }
  end
  
  def patterns
    throws = (0..6).to_a
    patterns = throws.repeated_permutation(@pattern_length)
    return patterns
  end
  
  def require_pattern(pattern)
    @required_sequence = pattern
  end
  
  def exclude_pattern(pattern)
    @excluded_sequence = pattern
  end
  
  def valid_patterns
    patterns.inject([]) { |acc, current|
      sum = sum(current)
      acc << current if is_valid?(current, sum)
      acc
    }
  end
  
  def sum(sequence)
    sequence.inject(:+)
  end

  def is_valid?(current, sum)
    correct_number?(sum) && 
    good_first_throw(current) && 
    correct_timing(current) &&
    Siteswap.repeat?(current) == false &&
    inclusion(current) &&
    exclusion(current)
  end
  
  def correct_number?(number)
    number/@pattern_length == @objects && number % @pattern_length == 0
  end
  
  def good_first_throw(current)
    current[0] > 2
  end
  
  def correct_timing(current)
    throws = adjusted_length(current)
    catches = [nil] * (current.length + current.last)
    throws.each_with_index do |duration, index|
      if catches[index+duration]
        return false
      else
        catches[index+duration] = true
      end
    end
    return true
  end
  
  def adjusted_length(current)
    more = 1
    extended = current.dup
    while required_length(current) > extended.length
      more += 1
      extended = current*more
    end
    extended.pop(extended.length - required_length(current))
    return extended
  end
  
  def required_length(current)
    ordered = []
    current.each_with_index do |x, index|
      ordered << x + index + 1
      ordered.sort!
    end
    return ordered.last
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
  
  def inclusion(current)
    return true if @required_sequence == nil || current.to_s.include?(@required_sequence)
  end
  
  def exclusion(current)
    return true if @excluded_sequence == nil
    if @excluded_sequence.length > 0 && current.to_s.include?(@excluded_sequence)
      return false 
    end
    return true
  end
end

