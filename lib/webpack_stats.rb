module WebpackStats
  REGEXP = /(.+?)(?:-([0-9a-f]{20,}))?\.(\w+)/
  RELOAD = !Rails.env.production?
  STATS_PATH = Rails.root.join('stats.json')

  class << self
    def assets
      load! if RELOAD || !@assets
      @assets
    end

    def stats
      load! if RELOAD || !@stats
      @stats
    end

    # load webpack stats file, process and store it.
    def load!
      if File.exists?(STATS_PATH)
        @stats = JSON.parse File.read STATS_PATH
        @assets = {}
        @stats['assets'].each do |asset|
          full_name, name, hash, ext = REGEXP.match(asset['name']).to_a
          @assets["#{name}.#{ext}"] = File.join(@stats['publicPath'], full_name)
        end
      else
        @stats = {}
        @assets = {}
      end
    end
  end
end