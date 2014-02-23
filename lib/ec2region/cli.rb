module EC2Region
  class CLI
    def run(args)
      regions = PageParser.new(open(REGION_PAGE_URL)).regions
      args.each do |ip|
        name = regions.find(ip) || "Not Match"
        puts "#{ip}: #{name}"
      end
    end
  end
end
