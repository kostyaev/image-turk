var ExtractTextPlugin = require('extract-text-webpack-plugin');
var HtmlWebpackPlugin = require('html-webpack-plugin');
var autoprefixer = require('autoprefixer');
var path = require('path');
var webpack = require('webpack');
var CopyWebpackPlugin = require('copy-webpack-plugin');

module.exports = {
  entry: './index.js',

  output: {
    filename: 'app.js',
    path: './dist',
  },

  resolve: {
    modulesDirectories: ['node_modules'],
    extensions: ['', '.js', '.elm'],
  },

  module: {
    noParse: /\.elm$/,

    loaders: [
      {
        test: /\.(png|jpg|otf|eot|ttf|woff|woff2|svg|json|gif)(\?.*)?$/,
        loader: 'file?name=[hash].[ext]',
      },

      {
        test:    /\.elm$/,
        exclude: [/elm-stuff/, /node_modules/],
        loader:  'elm-hot!elm-webpack',
      },

      {
        test: /\.(css|scss)$/,
        loader: ExtractTextPlugin.extract(
          'style-loader',
          'css-loader',
          'sass-loader',
          'postcss-loader'
        )
      },
    ],
  },

  plugins: [
    new CopyWebpackPlugin([
      {
        from: './assets/',
        to:   'assets/'
      }
    ]),

    new HtmlWebpackPlugin({
      filename: 'index.html',
      hash: true,
      template: './index.html'
    }),

    new webpack.optimize.OccurenceOrderPlugin(),

    new webpack.optimize.DedupePlugin(),

    new ExtractTextPlugin('./main.css', { allChunks: true }),

    new webpack.optimize.UglifyJsPlugin({
        minimize:   true,
        compressor: { warnings: false },
        // mangle:  true,
    }),
  ],
}
