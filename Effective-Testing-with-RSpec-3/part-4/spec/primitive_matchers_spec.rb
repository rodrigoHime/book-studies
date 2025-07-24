require 'uri'

RSpec.describe "Primitive Matchers", :aggregate_failures do

  specify do
    expect([String, RSpec]).to include(String)
    expect(['abc', RSpec]).to include(String)
    expect([String, RSpec]).to include(an_object_eq_to String)
    # expect(['abc', RSpec]).to include(an_object_eq_to String)
    expect(true).to be_truthy
    expect(0).to be_truthy
    expect(false).not_to be_truthy
    expect(nil).not_to be_truthy

    expect(false).to be_falsey
    expect(nil).to be_falsey
    expect(true).not_to be_falsey
    expect(0).not_to be_falsey

    expect(1).to be === 1
    expect(/foo/).to be =~ 'food'


    children = [
      { name: 'Coen', age: 6 },
      { name: 'Daphne', age: 4 },
      { name: 'Crosby', age: 2 },
    ]

    expect(children).to match [
                                { name: 'Coen', age: a_value > 5 },
                                { name: 'Daphne', age: a_value_between(3, 5) },
                                { name: 'Crosby', age: a_value < 3 },
                              ]

    expect('a string').to match(/str/)
    expect('a string').to match('str')

    expect(children).to contain_exactly(
                          { name: 'Coen', age: a_value > 5 },
                          { name: 'Daphne', age: a_value_between(3, 5) },
                          { name: 'Crosby', age: a_value < 3 },
                        )
    expect(children).to contain_exactly(
                          { name: 'Crosby', age: a_value < 3 },
                          { name: 'Coen', age: a_value > 5 },
                          { name: 'Daphne', age: a_value_between(3, 5) },
                        )

    uri = URI('http://github.com/rspec/rspec')
    expect(uri).to have_attributes(scheme: 'http', host: 'github.com', path: '/rspec/rspec')
    expect([uri]).to include(an_object_having_attributes(scheme: 'http', host: 'github.com', path: '/rspec/rspec'))

    expect{ raise('boom') }.to raise_error('boom')
    expect{ 'hello'.world }.to raise_error(an_object_having_attributes(name: :world))
    expect{ 'hello'.world }.to raise_error(NoMethodError) do |ex|
      p ex.methods
      expect(ex.name).to eq(:world)
    end
  end
end
