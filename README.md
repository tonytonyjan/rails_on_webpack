# Rails on Webpack

This product is a demonstration of integration between Rails and Webpack without using any ruby gem, including some frequently used packages such as:

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