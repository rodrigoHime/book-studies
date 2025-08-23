require_relative '../app/mountain/lib/skier'
# require_relative '../app/mountain/lib/trail_map'


# Check the verifying, non-verifying issues that can occurs with instance_doubles
# This example should raise a error but it pass due the trail_map double are not being verified against TrailMap class
module Mountain
  RSpec.describe Skier do
    it 'gets tired after skiing a difficulty slope' do
      # If TrailMap is not loaded or mistyped it wont be verified
      # trail_map = instance_double('TrailMap', difficulty: :expert)

      # If the dependency does not exists yet it will work well
      # trail_map = instance_double('Mountain::TrailMap', difficulty: :expert)

      # It will be verified if 'trail_map.rb' is loaded
      # trail_map = instance_double(TrailMap, difficulty: :expert)

      # It is the safest way to verify the double. But more expensive. Should fails once difficulty method does not exists
      trail_map = instance_double(Mountain::TrailMap, difficulty: :expert)

      skier = Skier.new(trail_map)
      skier.ski_on('Last Hoot')

      expect(skier).to be_tired
    end

  end
end
