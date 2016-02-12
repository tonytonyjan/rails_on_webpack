# Rails on Webpack

This product is a demonstration of integration between Rails and Webpack without using any ruby gem, including some usefule tools and packages such as:

- SASS
- CoffeeScript
- Material Design Icons

## Usage

```
bundle
npm i -D
foreman start
```

## Production Build

You can set `WEBPACK_ENV` environment variable to `production` to build optimized assets. Briefly, scripts are compressed, and styles will be extracted into a file.

## How it works?

It's simple to intergrate Rails with webpack by using the its stats file and overwriting `#compute_asset_path`.