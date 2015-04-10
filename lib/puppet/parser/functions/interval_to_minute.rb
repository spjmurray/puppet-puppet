# Given an integer calculate the cron minute field to run at the
# specified interval.  This is pseudo randomized by shifting by
# a number of minutes derived from the primary mac address
module Puppet::Parser::Functions
  newfunction(:interval_to_minute, :type => :rvalue) do |args|
    interval = args[0].to_i
    mac = lookupvar('macaddress')
    prn = mac.split(':')[3, 5].join('').hex % interval
    runs = 60 / interval
    (1..runs).map { |x| (x * interval + prn) % 60 }.sort
  end
end
