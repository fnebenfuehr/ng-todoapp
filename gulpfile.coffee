gulp   = require 'gulp'
gutil  = require 'gulp-util'

gulpif = require 'gulp-if'
clean  = require 'gulp-clean'

jade   = require 'gulp-jade'
tmpl   = require 'gulp-angular-templatecache'

coffee = require 'gulp-coffee'
stylus = require 'gulp-stylus'

concat  = require 'gulp-concat'
connect = require 'gulp-connect'


# Starts a simple webserver
gulp.task 'server', connect.server
  root: ['public']
  port: 3000
  livereload: true

gulp.task 'index', ->
  gulp.src('./public/index.html') # read: false
    .pipe clean()

  gulp.src(['./app/index.jade', './app/index.html'])
    .pipe gulpif(/[.]jade$/, jade().on('error', gutil.log))
    .pipe gulp.dest('./public')

gulp.task 'copy', ->
  # gulp.src(['./app/**/*.png', './app/**/*.gif'])
  #   .pipe .gulp.dest('public/i')

# task compiles all jades and
# wraps those in angular templateCache.
gulp.task 'templates', ->
  # TODO: module should be dynamic!
  # FIX: change the module: 'string' to the app name
  gulp.src(['./app/**/*.jade', './app/**/*.html', '!./app/index.*'])
    .pipe gulpif(/[.]jade$/, jade().on('error', gutil.log))
    .pipe tmpl('template.js', module:'todoapp') # standalone: true
    .pipe gulp.dest('./build')

gulp.task 'scripts', ->
  gulp.src(['./app/**/*.coffee', './app/**/*.js', '!./app/**/*_test.coffee', '!./app/**/*_test.js'])
    .pipe gulpif(/[.]coffee$/, coffee(bare: true).on('error', gutil.log))
    .pipe concat('scripts.js')
    .pipe gulp.dest('./build')

gulp.task 'styles', ->
  # TODO: Nib not always working
  gulp.src(['./app/**/*.styl', './app/**/*.css'])
    .pipe gulpif(/[.]styl$/, stylus(use: ['nib'], import: ['nib']).on('error', gutil.log))
    .pipe concat('styles.css')
    .pipe gulp.dest('./build')

gulp.task 'dependencies', ->
  # TODO: make something like a slug.json
  # gulp.src(['./node_modules/**/*.js', './bower_components/**/*.js', '!./node_modules/**/*.min.js', '!./bower_components/**/*min.js'])
  gulp.src(['./bower_components/**/*.js', '!./bower_components/**/*min.js'])
    .pipe concat('dependencies.js')
    .pipe gulp.dest('./build')

  gulp.src(['./bower_components/**/*.css', '!./bower_components/**/*min.css'])
    .pipe concat('dependencies.css')
    .pipe gulp.dest('./build')

gulp.task 'concat', ->
  gulp.src('./public/application.*')
    .pipe clean()

  gulp.src('./build/*.js')
    .pipe concat('application.js')
    .pipe gulp.dest('./public')

  gulp.src('./build/*.css')
    .pipe concat('application.css')
    .pipe gulp.dest('./public')

  # clean up build dir
  # gulp.src('./build/*')
  #   .pipe clean()

# uglify js for build (gulp-uglify / gulp-browserfy)
# minify css for build (gulp-styl)


gulp.task 'watch', ->
  # watch for livereload
  gulp.watch ['./public/*.html', './public/*.js', './public/*.css'], (e) ->
    gulp.src(e.path)
      .pipe connect.reload()

  # watch for build
  gulp.watch ['./app/index.jade'], ['index']
  gulp.watch ['./app/**/*.jade', './app/**/*.html'], ['templates']
  gulp.watch ['./app/*.coffee', './app/**/*.coffee', './app/**/*.js'], ['scripts']
  gulp.watch ['./app/**/*.styl', './app/**/*.css'], ['styles']
  gulp.watch ['./app/**/*.png', './app/**/*.gif'], ['copy']
  gulp.watch ['./build/*.js', './build/*.css'], ['concat']


# The default task (only watch for the begin)
gulp.task 'default', ['server', 'index', 'copy', 'templates', 'scripts', 'styles', 'dependencies', 'concat', 'watch']