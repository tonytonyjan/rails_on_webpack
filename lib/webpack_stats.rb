module WebpackStats
  REGEXP = /(.+?)(?:-([0-9a-f]{20,}))?\.(\w+)/
  RELOAD = !Rails.env.production?

  class << self
    def assets
      load! if RELOAD
      @assets
    end

    def stats
      load! if RELOAD
      @stats
    end

    def load!
      @stats = JSON.parse File.read Rails.root.join('stats.json')
      @assets = {}
      @stats['assets'].each do |asset|
        full_name, name, hash, ext = REGEXP.match(asset['name']).to_a
        @assets["#{name}.#{ext}"] = File.join(@stats['publicPath'], full_name)
      end
    end
  end
end