require 'nokogiri'

class Nova::Loader::IbUsedImages < Nova::Loader
  phony :ib_used_images

  def load(content)
    images = []
    Dir["#{Nova.src_root}/**/*.{xib,storyboard}"].each do |path|
      doc = Nokogiri::XML(File.open(path))
      doc.xpath('/document/resources/image/@name').each do |node|
        images << node.content.to_s
      end
    end
    images.uniq
  end
end
