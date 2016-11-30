var path = require('path')

module.exports = {
  entry: './client/main.js',
  output: {
    path: './app/assets/javascripts/',
    filename: 'app.js'
  },
  resolve: {
    modules: [path.resolve('./client'), path.resolve('./node_modules')]
  },
  module: {
    loaders: [{
      test: /\.js$/,
      exclude: /node_modules/,
      loader: 'babel-loader'
    }]
  }
}
