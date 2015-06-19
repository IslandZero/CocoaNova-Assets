class Nova::Loader::AssetNamesLoader < Nova::Loader
  phony :asset_names

  def load(content)
    Dir["#{Nova.src_root}/**/*.xcassets/*.imageset"].map do |file|
      File.basename file, '.*'
    end
  end
end
