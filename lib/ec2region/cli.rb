module EC2Region
  # The ec2region cli
  class CLI
    # Run cli with args
    # @param args [Array<String>] command line args
    def run(args)
      regions = PageParser.new(open(REGION_PAGE_URL)).regions
      args.each do |ip|
        name = regions.find(ip) || "Not Match"
        puts "#{ip}: #{name}"
      end
    end
  end
end
