# Command line interface
module PdfXcassets
  require 'pdf_xcassets/version'
  require 'fileutils'
  require 'json'
  require 'pathname'

  class << self
    CONTENTS_JSON = 'Contents.json'
    IMAGESET_EXTENSION = '.imageset'
    XCASSETS_EXTENSION = '.xcassets'

    def cli
      if ARGV.count != 2
        puts "Usage: #{PROJECT_NAME} <xcassets name> <assets directory> "
        exit
      end

      name, dir = ARGV

      n = xcassets_name name
      puts "> Creating xcassets named #{n}"

      files = get_pdf_assets dir
      puts "> PDF assets found: #{files.count}"

      exit unless files.count > 0

      FileUtils.rm_r(n) if Dir.exist? n
      xcassets_create n

      files.each_with_index do |x, i|
        puts "> #{i + 1} Processing #{x}"

        i = "#{n}/#{imageset dir, x}"
        puts "  > Creating #{i}"
        Dir.mkdir i

        puts '  > Copying pdf file to imageset'
        FileUtils.cp x, i

        j_filename = "#{i}/#{CONTENTS_JSON}"

        pn = Pathname.new x
        base = pn.basename

        j_content = {
          'images' => [
            {
              'idiom' => 'universal',
              'filename' => base
            }
          ],
          'info' => {
            'version' => 1,
            'author' => 'xcode'
          },
          'properties' => {
            'template-rendering-intent' => 'template'
          }
        }

        puts "  > Creating #{CONTENTS_JSON}"
        json_write j_filename, j_content
      end

      puts "> #{n} created"
      puts "> #{PROJECT_NAME} finished 🎉"
    end

    def json_write(filename, content)
      json = JSON.pretty_generate content
      File.open(filename, 'w') { |f| f.puts(json) }
    end

    def imageset(dir, file)
      match = dir + '/'
      file.sub(match, '').tr(' ', '-').tr('/', '-')
        .gsub('.pdf', IMAGESET_EXTENSION)
    end

    def get_pdf_assets(dir)
      dir += '/' unless dir.include? '/'
      glob = Dir.glob "#{dir}**/*"
      glob.select { |x| x.downcase.include? 'pdf' }
    end

    def xcassets_name(name)
      "#{name}#{XCASSETS_EXTENSION}"
    end

    def xcassets_create(n)
      Dir.mkdir n

      contents_json = "#{n}/#{CONTENTS_JSON}"
      puts "> Creating #{contents_json}"

      j =  {
        'info' => {
          'version' => 1,
          'author' => 'xcode'
        }
      }

      json_write contents_json, j
    end
  end # class
end
