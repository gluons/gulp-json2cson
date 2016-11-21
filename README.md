# gulp-json2cson
[![GitHub license](https://img.shields.io/github/license/gluons/gulp-json2cson.svg?style=flat-square)]()
[![npm](https://img.shields.io/npm/v/gulp-json2cson.svg?style=flat-square)](https://www.npmjs.com/package/gulp-json2cson)
[![npm](https://img.shields.io/npm/dt/gulp-json2cson.svg?style=flat-square)](https://www.npmjs.com/package/gulp-json2cson)
[![Travis branch](https://img.shields.io/travis/gluons/gulp-json2cson/node-6-buffer.svg?style=flat-square)](https://travis-ci.org/gluons/gulp-json2cson)

[Gulp](http://gulpjs.com/) plugin to parse JSON to CSON with [bevry/cson](https://github.com/bevry/cson)

If you want to parse CSON to JSON, use [gulp-cson](https://github.com/stevelacy/gulp-cson)

## Installation
[![NPM](https://nodei.co/npm/gulp-json2cson.png?downloads=true&downloadRank=true&stars=true)](https://www.npmjs.com/package/gulp-json2cson)
```
npm install --save-dev gulp-json2cson
```

## Usage
```javascript
var gulp = require('gulp');
var json2cson = require('gulp-json2cson');

gulp.task('json2cson', function () {
	return gulp.src('src/data.json')
		.pipe(json2cson())
		.pipe(gulp.dest('dest'));
});

gulp.task('default', ['json2cson']);
```
## API
### json2cson(indent)
Parse JSON to CSON with indentation.
```javascript
var gulp = require('gulp');
var json2cson = require('gulp-json2cson');

gulp.task('json2cson', function () {
	return gulp.src('src/data.json')
		.pipe(json2cson('\t'))
		.pipe(gulp.dest('dest'));
});
```
#### indent
Type: `String`  
Default: `  ` (2 spaces)

Indentation characters.
