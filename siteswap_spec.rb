require 'siteswap'

describe Siteswap do
  describe "patterns" do
    it "gives me a pattern" do
      siteswap = Siteswap.new(2, nil)
      siteswap.patterns.should include([5, 1])
    end
  end
  
  describe "correct_number?" do
    it "makes sure the sum of throws / number of throws == number of objects" do
      siteswap = Siteswap.new(2, 3)
      siteswap.correct_number?(6).should be_true
      siteswap.correct_number?(3).should_not be_true
    end
  end
  
  describe "good_first_throw" do
    it "makes sure the first throw is high enough" do
      siteswap = Siteswap.new(3, 3)
      siteswap.good_first_throw([6, 2, 2]).should be_true
      siteswap.good_first_throw([1, 2, 2]).should_not be_true
    end
  end
  
  describe "correct_timing" do
    it "makes sure the juggler only catches one object at a time" do
      siteswap = Siteswap.new(3, 3)
      siteswap.correct_timing([5, 3, 1]).should be_true
      siteswap.correct_timing([5, 4, 3]).should_not be_true
    end
  end
  
  describe "does_not_repeat" do
    it "doesn't return multi-throw patterns where the base sequence repeats" do
      siteswap = Siteswap.new(6, 3)
      siteswap.does_not_repeat([3, 3, 3, 3, 3, 3]).should be_empty
      # siteswap.does_not_repeat([4, 2, 3, 3, 2, 4]).should_not be_empty
      # siteswap.does_not_repeat([4, 2, 3, 4, 2, 3]).should be_empty
    end
  end
    
  describe "valid_patterns" do
    it "returns valid patterns" do
      siteswap = Siteswap.new(2, 3)
      siteswap.valid_patterns.should include([4, 2], [5, 1])
    end
  end
end

    