module WebpackStats
  REGEXP = /(.+?)(?:-([0-9a-f]{20,}))?\.(\w+)/

  @reload = defined?(::Rails) && ::Rails.env.production? ? false : true
  @stats_path = defined?(::Rails) ? ::Rails.root.join('stats.json') : 'stats.json'

  class << self
    attr_accessor :reload, :stats_path

    def configure
      yield self
    end

    def assets
      @reload ? load_assets : @assets ||= load_assets
    end

    def stats
      @reload ? load_stats : @stats ||= load_stats
    end

    def load_stats
      JSON.parse File.read @stats_path
    end

    def load_assets
      ret = {}
      stats['assets'].each do |asset|
        full_name, name, hash, ext = REGEXP.match(asset['name']).to_a
        ret["#{name}.#{ext}"] = File.join(stats['publicPath'], full_name)
      end
      ret
    end

  end

  if defined? ::Rails
    module Helper
      def compute_asset_path source, options = {}
        WebpackStats.assets[source] || super
      end
    end
  end

end

if defined? ::ActiveSupport
  ActiveSupport.on_load(:action_view) do
    include WebpackStats::Helper
  end
end