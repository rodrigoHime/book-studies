class Sandwich
  attr_accessor :taste, :bread, :fillings, :sauces

  # Initialize method to define attributes of a sandwich
  def initialize(taste, bread, fillings = [], sauces = [])
    @taste = taste
    @bread = bread
    @fillings = fillings
    @sauces = sauces
  end

  # Method to describe the sandwich
  def describe
    description = "This sandwich is made with #{@bread} bread."
    description += " It contains #{fillings.join(', ')}." unless @fillings.empty?
    description += " It is topped with #{sauces.join(', ')} sauce(s)." unless @sauces.empty?
    description
  end

  # Method to add a filling
  def add_filling(filling)
    @fillings << filling
  end

  # Method to add a sauce
  def add_sauce(sauce)
    @sauces << sauce
  end

  def taste
    @taste
  end
end

# Example usage:
sandwich = Sandwich.new("whole grain", ["turkey", "lettuce"], ["mayonnaise"])
puts sandwich.describe

sandwich.add_filling("tomato")
sandwich.add_sauce("mustard")
puts sandwich.describe