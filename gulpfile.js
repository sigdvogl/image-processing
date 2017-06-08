var gulp = require('gulp');

// Plugins einbauen
var changed = require('gulp-changed'),
    rename = require('gulp-rename'),
    imageResize = require('gulp-image-resize'),
    imagemin = require ('gulp-imagemin'),
    watch = require('gulp-watch');

// Pfade festlegen
var imgSrc = 'images/300dpi/**/*',
    imgDst = 'images/';

var defaultTasks = [
    'thumb',
    'large'
];

gulp.task('default', defaultTasks);

// Watch images files and resize and optimize
gulp.task('images', function() {
    console.log('\n---\n\n Watching Images, Optimizing Images \n\n---\n')
    gulp.watch(imgSrc, ['thumb', 'imagemin']);
});


gulp.task('watchi', function() {
    gulp.watch(imgSrc)
        .on('change', function(file) {
            gulp.src(file.path)
                .pipe(imageResize({
                    width : 250,
                    height : 250,
                    crop : false,
                    upscale : false,
                    imageMagick: true
                }))
                .pipe(imagemin())
                .pipe(gulp.dest(imgDst + '250x250/'));

            gulp.src(file.path)
                .pipe(imageResize({
                    width : 2000,
                    height : 2000,
                    crop : false,
                    upscale : false,
                    imageMagick: true
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