Event = Struct.new(:name, :capacity) do
  def purchase_ticket_for(guest)
    tickets_sold << guest
  end

  def tickets_sold
    @tickets_sold ||= []
  end

  def inspect
    "#<Event: #{name.inspect}, (capacity: #{capacity})>"
  end
end

RSpec::Matchers.define :have_no_tickets_sold do
  match { |event| event.tickets_sold.empty? }
  failure_message { |event| super() + ", but it has #{event.tickets_sold.count} tickets sold." }
  failure_message_when_negated { |event| super() + ", but it has #{event.tickets_sold.count} tickets sold." }
end

RSpec::Matchers.define :be_sold_out do
  match { |event| event.tickets_sold.count == event.capacity }
  failure_message { |event| super() + ", but it has #{event.capacity - event.tickets_sold.count} tickets unsold." }
  failure_message_when_negated { |event| super() + ", but it has #{event.capacity - event.tickets_sold.count.count} tickets unsold." }
end


RSpec.describe '`have_no_tickets_sold` matcher' do
  example 'passing expectation' do
    art_show = Event.new('Art Show', 100)

    expect(art_show).to have_no_tickets_sold
  end

  example 'failing expectation' do
    art_show = Event.new('Art Show', 100)
    art_show.purchase_ticket_for(:a_friend)

    expect(art_show).to have_no_tickets_sold
  end
end

RSpec.describe '`be_sold_out` matcher' do
  example 'passing expectation' do
    u2_concert = Event.new('U2 Concert', 10_000)
    10_000.times { u2_concert.purchase_ticket_for(:a_fan) }

    expect(u2_concert).to be_sold_out
  end

  example 'failing expectation' do
    u2_concert = Event.new('U2 Concert', 10_000)
    9_999.times { u2_concert.purchase_ticket_for(:a_fan) }

    expect(u2_concert).to be_sold_out
  end
end

