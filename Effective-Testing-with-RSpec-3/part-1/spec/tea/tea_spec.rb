class Tea
  def initialize(flavor)
    @flavor = flavor
    @temperature = 205.0
  end

  def flavor
    @flavor
  end

  def temperature
    @temperature
  end
end

RSpec.configure do |config|
  config.example_status_persistence_file_path = "spec/.rspec_status"
end

RSpec.describe Tea do
  let(:tea) { Tea.new(:earl_grey) }

  it 'tastes like Earl Grey' do
    expect(tea.flavor).to be :earl_grey
  end

  it 'is hot' do
    expect(tea.temperature).to be > 200.0
  end
end