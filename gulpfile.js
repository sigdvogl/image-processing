var gulp = require('gulp');

// Plugins einbauen
var changed = require('gulp-changed'),
    rename = require('gulp-rename'),
    imageResize = require('gulp-image-resize'),
    imagemin = require ('gulp-imagemin'),
    plumber = require ('gulp-plumber')
    watch = require('gulp-watch');

// Pfade festlegen
var imgSrc = [
        'images/300dpi/**/*.jpg',
        'images/300dpi/**/*.jpeg'
    ],
    imgDst = 'images/';

var defaultTasks = [
    'watch'
];

gulp.task('default', defaultTasks);

// Watch images files and resize and optimize
gulp.task('images', function() {
    console.log('\n---\n\n Watching Images, Optimizing Images \n\n---\n')
    gulp.watch(imgSrc, ['thumb', 'imagemin']);
});


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

// Bilder und Vektoren minifizieren
gulp.task('imagemin', function() {
    gulp.src(imgSrc)
        .pipe(changed(imgDst))
        .pipe(imagemin())
        .pipe(gulp.dest(imgDst));
});

gulp.task('thumb', function () {
    gulp.src(imgSrc)
        .pipe(imageResize({
            width : 250,
            height : 250,
            crop : false,
            upscale : false,
            imageMagick: true
        }))
        .pipe(imagemin())
        // .pipe(rename({suffix: '-thumb'}))
        .pipe(gulp.dest(imgDst+'/250x250/'));
});

gulp.task('large', function () {
    gulp.src(imgSrc)
        .pipe(imageResize({
            width : 2000,
            height : 2000,
            crop : false,
            upscale : false,
            imageMagick: true
        }))
        .pipe(imagemin())
        // .pipe(rename({suffix: '-large'}))
        .pipe(gulp.dest(imgDst+'2000x2000'));
});