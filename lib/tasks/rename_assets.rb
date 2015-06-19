require 'json'
require 'fileutils'
require 'RMagick'

include Magick

class Nova::Task::RenameAssets < Nova::Task
  task :rename_assets

  def invoke(params={})
    Dir["#{Nova.src_root}/**/*.imageset"].each do |path|
      name  = File.basename path, '.*'
      index = JSON.load File.open("#{path}/Contents.json")
      file2x = nil
      file3x = nil
      index['images'].each do |image|
        filename = image['filename']
        next if filename.nil?
        scale    = image['scale']
        nfilename= scale == '1x' ? "#{name}.png" : "#{name}@#{scale}.png"
        unless filename == nfilename
          FileUtils.mv "#{path}/#{filename}", "#{path}/#{nfilename}"
          image['filename'] = nfilename
        end
        if scale == '2x'
          file2x = "#{path}/#{nfilename}"
        end
        if scale == '3x'
          file3x = "#{path}/#{nfilename}"
        end
      end
      if file2x
        if file3x
          image2x = ImageList.new file2x
          image3x = ImageList.new file3x

          w2 = image2x.columns.to_f
          h2 = image2x.rows.to_f

          w3 = image3x.columns.to_f
          h3 = image3x.rows.to_f

          if w3/w2 != 1.5 or h3/h2 != 1.5
            puts "WARN: #{name}\n    @3x = {#{w3},#{h3}}\n    @2x = {#{w2}, #{h2}}\n    w3/w2: #{w3/w2}\n    h3/h2: #{h3/h2}"
          end
        end
      end
      File.open("#{path}/Contents.json", 'w').write JSON.generate(index)
    end
  end
end
