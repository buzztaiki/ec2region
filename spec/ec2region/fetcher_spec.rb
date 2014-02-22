require 'spec_helper'
require 'nokogiri'
require 'ec2region/fetcher'
require 'ipaddr'

describe EC2Region::Fetcher do
  context 'open regions.html' do
    it {
      expect{ EC2Region::Fetcher.new(open('spec/regions.html')) }.to_not raise_error
    }
  end

  describe '.br_to_newline' do
    it 'should split element by br' do
      doc = Nokogiri::HTML('a<br>b<br/>c')
      expect(EC2Region::Fetcher.replace_br(doc, "\n").content).to eq "a\nb\nc"
    end
  end

  describe "#regions" do
    context "with spec/regions.html" do
      let(:fetcher) { EC2Region::Fetcher.new(open('spec/regions.html')) }
      subject(:regions) { fetcher.regions }
      its(:names) { should include('US East (Northern Virginia)', 'Asia Pacific (Tokyo)') }

      it "should contain ip address" do
        subject.names.each do |name|
          ips = subject.region_ips(name)
          expect { ips.map { |ip| IPAddr.new(ip) } }.to_not raise_error
        end
      end
    end
  end
end
