require 'pdf_xcassets'
require 'json'
# require 'pp'

ASSET = 'resources'
PATH = 'test/fixtures'

CONTENTS = 'Contents.json'
INFO = 'info'
VERSION = 'version'
AUTHOR = 'author'

def check_key(hash, key)

  unless hash.key? key
    puts "Missing #{key} 🔴"
    exit 1
  end
end

xcassets = "#{ASSET}.xcassets"
path = "#{xcassets}/#{CONTENTS}"
puts "Checking for #{path}"
exit 1 unless File.exist? path
puts "#{CONTENTS} is created ✅"

print "Checking #{CONTENTS} format "
c = JSON.load File.new(path)
puts '✅'

check_key c, INFO
check_key c[INFO], VERSION
check_key c[INFO], AUTHOR
puts "Keys are present in #{CONTENTS} ✅"

print 'Checking number of assets '
pdf = PdfXcassets::get_pdf_assets PATH + '/'
expect = 3
exit 1 unless expect == pdf.count
puts '✅'

glob = Dir.glob "#{xcassets}/**/*"
imagesets = glob.select { |x| x.downcase.include? 'imageset' }
expect = 9
exit 1 unless expect == imagesets.count
puts 'Correct number of imagesets ✅'
