require 'webpack_stats'
module WebpackHelper
  def compute_asset_path source, options = {}
    WebpackStats.assets[source] || super
  end
end
