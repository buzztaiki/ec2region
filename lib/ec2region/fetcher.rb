require 'nokogiri'
require 'open-uri'

module EC2Region
  class Fetcher
    # see script of https://forums.aws.amazon.com/ann.jspa?annID=1701
    REGION_PAGE_URL = 'https://forums.aws.amazon.com/ann.jspa?annID=1701&state=hashArgs%23'

    def initialize(thing)
      @doc = Nokogiri::HTML(thing)
    end

    class << self
      def open
        return Fetcher.new(OpenURI.open_uri(REGION_PAGE_URL))
      end

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
      Fetcher.replace_br(body, "\n").content.split("\n")
    end
  end
end
