require 'ipaddr'

module EC2Region
  class Regions
    # @param [Hash{String => Array<String>}] regions_hash
    def initialize(regions_hash)
      @regions = regions_hash
    end

    # @return [Array<String>] name of regions
    def names
      @regions.keys
    end

    # @param [String] name region name
    # @return [Array<String>] ips of specified region
    def region_ips(name)
      @regions[name]
    end

    # @param [String] ip ip address
    # @return [String, nil] region name of this ip
    def find(ip)
      match = @regions.find do |name, ips|
        ips.find { |x| IPAddr.new(x).include?(ip) }
      end
      match[0] if match
    end
  end
end
