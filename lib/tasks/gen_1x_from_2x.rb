require 'json'
require 'fileutils'
require 'RMagick'

include Magick

class Nova::Task::Gen1X < Nova::Task
  task :gen_1x_from_2x

  def invoke(params={})
    Dir["#{Nova.src_root}/**/*.imageset"].each do |path|
      name  = File.basename path, '.*'
      index = JSON.load File.open("#{path}/Contents.json")
      file2x = nil
      file1x = nil
      index['images'].each do |image|
        filename = image['filename']
        next if filename.nil?
        case image['scale']
        when '2x'
          file2x = "#{path}/#{filename}"
        when '1x'
          file1x = "#{path}/#{filename}"
        end
      end
      if file2x
        puts "Gen 1x: #{name}"
        image2x = ImageList.new file2x
        image1x = image2x.minify
        if file1x
          image1x.write file1x
        else
          filename1x = "#{name}.png"
          file1x = "#{path}/#{filename1x}"
          image1x.write file1x
          index['images'] << { "idiom" => "universal","scale" => "1x", "filename" => filename1x }
          File.open("#{path}/Contents.json", 'w').write JSON.generate(index)
        end
      end
    end
  end
end
