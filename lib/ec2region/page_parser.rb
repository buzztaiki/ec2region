require 'nokogiri'
require 'open-uri'

module EC2Region
  # The parser that parse ec2 regions page html.
  class PageParser
    # @param [String] html the regions page html
    def initialize(html)
      @doc = Nokogiri::HTML(html)
    end

    class << self
      # replace br tag to sep in element
      # @param element [Nokogiri::XML::Node]
      # @param sep [String] replacement separator
      def replace_br(element, sep)
        e = element.dup
        e.search('br').each do |br|
          br.replace(sep)
        end
        e
      end
    end

    # @return [Regions] regions of page
    def regions
      body = @doc.css('div.jive-body').first
      h = {}
      region = nil
      self.class.replace_br(body, "\n").content.split("\n").each do |line|
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
