gulp   = require 'gulp'
coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'
concat = require('gulp-concat')
uglify = require('gulp-uglify')
rename = require('gulp-rename')

# pkg = require('./package.json')
# banner = "/*! #{ pkg.name } #{ pkg.version } */\n"

gulp.task 'coffee', ->
  gulp.src('app/*.coffee')
    .pipe coffee()
    .pipe concat('application.js')
    .pipe gulp.dest('./public/')

gulp.task 'stylus', ->
  gulp.src('styl/*.styl')
    .pipe stylus(use: ['nib'])
    .pipe concat('application.css')
    .pipe gulp.dest('./public/')

gulp.task 'uglify', ->
  gulp.src('public/*.js')
      .pipe uglify(outSourceMap: true)
      .pipe gulp.dest('./public/')


gulp.task 'watch', ->
  gulp.watch 'app/*.coffee', ['coffee']
  gulp.watch 'styl/*.styl' , ['stylus']


# The default task (called when you run `gulp` from cli)
gulp.task 'default', ['coffee', 'watch']

# build app
gulp.task 'build', ['coffee', 'stylus', 'uglify']