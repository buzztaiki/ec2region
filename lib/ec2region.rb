require 'ec2region/cli'
require 'ec2region/fetcher'
require 'ec2region/regions'

module EC2Region
  # The regoin page url.
  # see script of https://forums.aws.amazon.com/ann.jspa?annID=1701
  REGION_PAGE_URL = 'https://forums.aws.amazon.com/ann.jspa?annID=1701&state='
end
