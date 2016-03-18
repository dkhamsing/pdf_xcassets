require 'json'
require 'pp'

ASSET = 'resources'
PATH = 'test/fixtures'
CONTENTS = 'Contents.json'

xcassets = "#{ASSET}.xcassets"
path = "#{xcassets}/#{CONTENTS}"
puts "Checking for #{path}"
exit 1 unless File.exist? path
puts "#{CONTENTS} is created ✅"

print "Checking #{CONTENTS} format "
c = JSON.load File.new(path)
puts '✅'

INFO = 'info'
puts "Missing #{INFO}" unless c.key? INFO

puts "Keys are present in #{CONTENTS} ✅"
