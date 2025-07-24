require 'date'

Calendar = Struct.new(:date_string) do
  def on_weekend?
    Date.parse(date_string).saturday?
  end
end

RSpec.describe Calendar do
  let(:sunday_date) { Calendar.new('Sun, 11 Jun 2017') }

  it 'considers sundays to be on the weekend' do
    # expect(sunday_date.on_weekend?).to be true

    # Improves failure message readability
    # expected `#<struct Calendar date_string="Sun, 11 Jun 2017">.on_weekend?` to be truthy, got false
    expect(sunday_date).to be_on_weekend
  end
end