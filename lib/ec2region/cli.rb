module EC2Region
  class CLI
    def run(args)
      regions = EC2Region::Fetcher.open.regions
      args.each do |ip|
        name = regions.find(ip) || "Not Match"
        puts "#{ip}: #{name}"
      end
    end
  end
end
