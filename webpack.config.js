const __PRODUCTION__ = process.env.WEBPACK_ENV == 'production'

if (__PRODUCTION__) {
  var UglifyJsPlugin = require('webpack/lib/optimize/UglifyJsPlugin')
  var ExtractTextPlugin = require('extract-text-webpack-plugin')
}

var CONFIG = {
  entry: './app/assets/javascripts/application.coffee',
  output: {
    path: __dirname + '/public/assets',
    filename: 'application.js',
    publicPath: '/assets/'
  },
  plugins: [
    function() {
      this.plugin('done', function(stats) {
        require('fs').writeFileSync(__dirname + '/stats.json', JSON.stringify(stats.toJson()))
      })
    }
  ],
  module: {
    loaders: [{
      test: /\.scss$/,
      loader: __PRODUCTION__ ? ExtractTextPlugin.extract('style', 'css!sass') : 'style!css!sass'
    }, {
      test: /\.(jpg|png|gif|ttf|eot|svg|woff2?)$/,
      loader: __PRODUCTION__ ? 'file?name=[name]-[hash].[ext]' : 'file?name=[name].[ext]'
    }, {
      test: /\.coffee$/,
      loader: 'coffee'
    }]
  }
}

if (__PRODUCTION__) {
  CONFIG.plugins.push(
    new ExtractTextPlugin('application-[hash].css'),
    new UglifyJsPlugin()
  )
  CONFIG.output.filename = 'application-[hash].js'
}

module.exports = CONFIG