require 'spec_helper'
require 'ec2region/regions'

describe EC2Region::Regions, 'with Tokyo and US East' do
  let(:region_hash) {
    {
      'Tokyo' => ['175.41.192.0/18', '46.51.224.0/19'],
      'US East' => ['72.44.32.0/19', '67.202.0.0/18']
    }
  }
  subject(:regions) { EC2Region::Regions.new(region_hash) }
  its(:names) { should include('Tokyo', 'US East') }

  describe '#region_ips' do
    context 'of Tokyo' do
      subject(:ips) { regions.region_ips('Tokyo') }
      it { should include(*region_hash['Tokyo']) }
    end
    context 'of Unknown' do
      subject(:ips) { regions.region_ips('Osaka') }
      it { should be_nil }
    end
  end

  describe '#find' do
    it 'should find region of valid address' do
      expect(regions.find('175.41.192.0')).to eq('Tokyo')
      expect(regions.find('175.41.192.1')).to eq('Tokyo')
      expect(regions.find('67.202.63.255')).to eq('US East')
    end

    it 'should not find region of invalid address' do
      expect(regions.find('192.168.0.1')).to be_nil
    end
  end
end
