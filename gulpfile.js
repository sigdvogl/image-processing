var gulp = require('gulp');

// Plugins einbauen
var changed = require('gulp-changed'),
    rename = require('gulp-rename'),
    imageResize = require('gulp-image-resize'),
    imagemin = require ('gulp-imagemin'),
    plumber = require ('gulp-plumber'),
    watch = require('gulp-watch'),
    parallel = require("concurrent-transform"),
    os = require("os"),
    gutil = require('gulp-util'),
    logger = require('gulp-logger');

// Pfade festlegen
var imgSrc = [
        'images/300dpi/**/*.jpg',
        'images/300dpi/**/*.jpeg'
    ],
    imgDst = 'images/';

var defaultTasks = [
    'watch'
];

var resizeTasks = [
    'thumb',
    'large'
];

var resize = function(src, dest, options) {
    gulp.src(src)
        .pipe(plumber())
        // .pipe(logger({
        //     before: 'Starting Converting ...',
        //     after: 'Converting complete!',
        //     showChange: true
        // }))
        .pipe(parallel(
            imageResize(options),
            os.cpus().length
        ))
        .pipe(parallel(
            imagemin(),
            os.cpus().length
        ))
        // .pipe(rename({suffix: '-large'}))
        .pipe(gulp.dest(dest))
};

gulp.task('default', defaultTasks);
gulp.task('resize', resizeTasks);

gulp.task('watch', function() {
    gulp.watch(imgSrc)
        .on('change', function(file) {
            gulp.src(file.path)
                .pipe(plumber())
                .pipe(imageResize({
                    width : 250,
                    height : 250,
                    crop : false,
                    upscale : false,
                    imageMagick: true,
                    quality: 0.75,
                    sharpen: true,
                    noProfile: true
                }))
                .pipe(imagemin())
                .pipe(gulp.dest(imgDst + '250x250/'));

            gulp.src(file.path)
                .pipe(plumber())
                .pipe(imageResize({
                    width : 2000,
                    height : 2000,
                    crop : false,
                    upscale : false,
                    imageMagick: true,
                    quality: 0.9,
                    noProfile: true
                }))
                .pipe(imagemin())
                .pipe(gulp.dest(imgDst + '2000x2000/'));
        })
});

gulp.task('thumb', resize(imgSrc, imgDst + '250x250', {
    width : 250,
    height : 250,
    crop : false,
    upscale : false,
    imageMagick: true,
    quality: 0.75,
    sharpen: true,
    noProfile: true
}));

gulp.task('large', resize(imgSrc, imgDst + '2000x2000', {
    width : 2000,
    height : 2000,
    crop : false,
    upscale : false,
    imageMagick: true,
    quality: 0.9,
    noProfile: true
}));

