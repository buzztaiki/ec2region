require 'spec_helper'
require 'nokogiri'
require 'ec2region/fetcher'

describe EC2Region::Fetcher do
  it 'should open regions.html' do
    EC2Region::Fetcher.new(open('spec/regions.html')).should_not == nil
  end

  describe '.br_to_newline' do
    it 'should split element by br' do
      doc = Nokogiri::HTML('a<br>b<br/>c')
      EC2Region::Fetcher.replace_br(doc, "\n").content.should == "a\nb\nc"
    end
  end

  describe "#regions" do
    context "with spec/regions.html" do
      let(:fetcher) { EC2Region::Fetcher.new(open('spec/regions.html')) }
      subject(:regions) { fetcher.regions }
      its(:size) { should > 0 }
      its(:keys) {
        should == [
          'US East (Northern Virginia)',
          'US West (Oregon)',
          'US West (Northern California)',
          'EU (Ireland)',
          'Asia Pacific (Singapore)',
          'Asia Pacific (Sydney)',
          'Asia Pacific (Tokyo)',
          'South America (Sao Paulo)',
          'GovCloud',
        ]
      }
    end
  end
end
