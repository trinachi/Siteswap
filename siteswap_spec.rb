require 'siteswap'
require 'input'

describe Siteswap do
  describe "patterns" do
    it "gives me a pattern" do
      @siteswap = Siteswap.new(2, nil)
      @siteswap.patterns.should include([5, 1])
    end
  end
    
  describe "valid_patterns" do
    it "returns patterns where the sum of throws / number of throws = number of objects" do
      @siteswap = Siteswap.new(2, 3)
      @siteswap.valid_patterns.should include([4, 2], [5, 1])
    end
  
    it "doesn't return patterns that don't match the number of objects" do
      @siteswap = Siteswap.new(2, 2)
      @siteswap.valid_patterns.should_not include([4, 2], [5, 1])
    end
    
    it "returns valid throw/catch patterns" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should include([5, 3, 1])
    end
  
    it "doesn't return invalid throw/catch patterns" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should_not include([5, 4, 3])
    end
  
    it "doesn't return invalid throw/catch patterns" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should_not include([6, 1, 4])
    end
  
    it "tests for other invalid throw/catch patterns" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should_not include([3, 1, 4])
    end
  
    it "tests for different object and pattern length combinations" do
      @siteswap = Siteswap.new(4, 4)
      @siteswap.valid_patterns.should include([5, 5, 5, 1])
    end
    
    it "doesn't return patterns that start with a throw height of 0 - 2" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should_not include([1, 2, 6])
    end
    
    it "doesn't return multi-throw patterns where every number is the same" do
      @siteswap = Siteswap.new(3, 3)
      @siteswap.valid_patterns.should_not include([3, 3, 3])
    end
    
    it "doesn't return multi-throw patterns where the base sequence repeats" do
      @siteswap = Siteswap.new(4, 2)
      @siteswap.valid_patterns.should_not include([3, 1, 3, 1])
    end
  end
end

describe Input do
  describe "start" do
    before(:each) do
      @input = Input.new
    end
      
    it "asks the user to enter the number of objects" do pending
      @input.start.should include("Number of objects:")
    end
  end
end

    