require 'spec_helper'

describe 'Super Zombies API' do

  it 'should return zombies.json' do
    VCR.use_cassette('zombies') do
      client   = SuperZombiesApi::Client.new
      response = client.zombies

      response.count.should == 3

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
    VCR.use_cassette('zombie_create') do
      client = SuperZombiesApi::Client.new
      zombie = client.reanimate \
        :name     => 'UUURRGGH',
        :gender   => 'Male',
        :age      => 22,
        :brain_id => 1,
        :gut_id   => 1

      zombie['id'].should                  == 7
      zombie['name'].should                == 'UUURRGGH'
      zombie['gender'].should              == 'Male'
      zombie['age'].should                 == 22
      zombie['created_at'].should          == '2012-03-26T05:43:57Z'
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
    pending 'i write code'
  end
end
