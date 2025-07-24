class CookieRecipe
  attr_accessor :ingredients

  def initialize
    @ingredients = [:butter, :milk, :flour, :sugar, :eggs, :chocolate_chips]
  end
end


RSpec.describe CookieRecipe, '#ingredients' do
  # it 'should include :butter, :milk and :eggs' do
  #   expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs)
  # end
  #
  # it 'should not include :fish_oil' do
  #   expect(CookieRecipe.new.ingredients).to_not include(:fish_oil)
  # end
  # specify do
  #   expect(CookieRecipe.new.ingredients).to include(:butter, :milk, :eggs)
  # end
  #
  # specify do
  #   expect(CookieRecipe.new.ingredients).to_not include(:fish_oil)
  # end
  subject { CookieRecipe.new.ingredients }
  # it { is_expected.to include(:butter, :milk, :flour, :sugar, :eggs) }
  # it { is_expected.to_not include(:fish_oil) }
  it { should include(:butter, :milk, :flour, :sugar, :eggs) }
  it { should_not include(:fish_oil) }
end
