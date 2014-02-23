require 'nokogiri'
require 'open-uri'

module EC2Region
  class Fetcher
    def initialize(thing)
      @doc = Nokogiri::HTML(thing)
    end

    class << self
      # replace br tag to sep in element
      def replace_br(element, sep)
        e = element.dup
        e.search('br').each do |br|
          br.replace(sep)
        end
        e
      end
    end

    def regions
      body = @doc.css('div.jive-body').first
      h = {}
      region = nil
      Fetcher.replace_br(body, "\n").content.split("\n").each do |line|
        line.strip!
        next if line.empty?

        if /^[0-9.]+{4}\/[0-9]+/ =~ line
          h[region] << $&
        else
          region = line.sub(/:$/, '').strip
          h[region] = []
        end
      end
      Regions.new(h.select {|k, v| !v.empty?})
    end
  end
end
