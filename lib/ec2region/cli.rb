require 'optparse'

module EC2Region
  # The ec2region cli
  class CLI
    # Run cli with args
    # @param progname [String] the program name
    # @param args [Array<String>] the command line args
    # @return [Integer] the result status
    def run(progname, args)
      opts = OptionParser.new
      opts.banner = "Usage: #{progname} IP..."
      args = opts.parse(args)
      if args.empty?
        $stderr.puts opts.help
        return 1
      end

      regions = PageParser.new(open(REGION_PAGE_URL)).regions
      args.each do |ip|
        name = regions.find(ip) || "Not Match"
        puts "#{ip}: #{name}"
      end

      return 0
    end
  end
end
