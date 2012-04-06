require 'spec_helper'

describe 'Super Zombies API' do

  it 'should return zombies.json' do
    VCR.use_cassette('get_zombies') do
      client   = SuperZombiesApi::Client.new
      response = client.zombies

      response.count.should == 5

      zombie = response.first

      zombie['id'].should                  == 3
      zombie['name'].should                == 'Blobby'
      zombie['gender'].should              == 'Male'
      zombie['age'].should                 == 17
      zombie['created_at'].should          == '2012-03-17T21:29:27Z'
      zombie['brain']['id'].should         == 1
      zombie['brain']['kind'].should       == 'Insane'
      zombie['brain']['size'].should       == 'Huge'
      zombie['brain']['created_at'].should == '2012-03-18T23:59:59Z'
      zombie['gut']['id'].should           == 1
      zombie['gut']['kind'].should         == 'Juicy'
      zombie['gut']['species'].should      == 'Cow'
      zombie['gut']['created_at'].should   == '2012-03-19T03:13:10Z'
    end
  end

  it 'should create a new zombie via the reanimate method' do
    VCR.use_cassette('post_zombies') do
      client = SuperZombiesApi::Client.new
      zombie = client.reanimate \
        :name     => 'UUURRGGH',
        :gender   => 'Male',
        :age      => 22,
        :brain_id => 1,
        :gut_id   => 1

      zombie['id'].should                  == 8
      zombie['name'].should                == 'UUURRGGH'
      zombie['gender'].should              == 'Male'
      zombie['age'].should                 == 22
      zombie['created_at'].should          == '2012-04-02T17:46:13Z'
      zombie['brain']['id'].should         == 1
      zombie['brain']['kind'].should       == 'Insane'
      zombie['brain']['size'].should       == 'Huge'
      zombie['brain']['created_at'].should == '2012-03-18T23:59:59Z'
      zombie['gut']['id'].should           == 1
      zombie['gut']['kind'].should         == 'Juicy'
      zombie['gut']['species'].should      == 'Cow'
      zombie['gut']['created_at'].should   == '2012-03-19T03:13:10Z'
    end
  end

  it 'should allow for batch creation via the horde method' do
    VCR.use_cassette('horde_post') do
      client = SuperZombiesApi::Client.new

      horde_data = { :zombies => [] }

      2.times do |i|
        horde_data[:zombies] << {
          :name        => "Zombie #{ i + 1 }",
          :gender      => 'Female',
          :age         => 22,
          :brain_kind  => 'Damaged',
          :brain_size  => 'Medium',
          :gut_kind    => 'Juicy',
          :gut_species => 'Bear'
        }
      end

      horde = client.horde(horde_data)

      horde.count.should == 2

      horde.each_with_index do |zombie, i|
        zombie['id'].should                  == i + 1
        zombie['name'].should                == "Zombie #{ i + 1}"
        zombie['gender'].should              == 'Female'
        zombie['age'].should                 == 22
        zombie['created_at'].should          == '2012-04-05T23:42:42Z'
        zombie['brain']['id'].should         == i + 1
        zombie['brain']['kind'].should       == 'Damaged'
        zombie['brain']['size'].should       == 'Medium'
        zombie['brain']['created_at'].should == '2012-04-05T23:42:42Z'
        zombie['gut']['id'].should           == i + 1
        zombie['gut']['kind'].should         == 'Juicy'
        zombie['gut']['species'].should      == 'Bear'
        zombie['gut']['created_at'].should   == '2012-04-05T23:42:42Z'
      end
    end
  end
end
