"use strict"

var gulp = require("gulp"),
    purescript = require("gulp-purescript"),
    run = require("gulp-run");

var sources = [
    "src/**/*.purs",
    "bower_components/purescript-*/src/**/*.purs"
];

var foreigns = [
    "src/**/*.js",
    "bower_components/purescript-*/src/**/*.js"
];

var exampleSources = [
    "example/src/**/*.purs"
];

var exampleForeigns = [
    "example/src/**/*.js"
];

gulp.task("make-example", function() {
    return purescript.psc({
        src: sources.concat(exampleSources),
        ffi: foreigns.concat(exampleForeigns),
        output: "example/node_modules"
    });
});

gulp.task("make-tests", function() {
    return purescript.psc({
        src: sources.concat(testSources),
        ffi: foreigns.concat(testForeigns),
        output: "test/node_modules"
    });
});

gulp.task("watch-example", ["make-example"], function() {
    gulp.watch(source.concat(foreigns).concat(exampleSources).concat(exampleForeigns),
               ["make-example"]
              );
});

gulp.task("docs", function() {
    return purescript.pscDocs({
        src: sources,
        docgen: {
            "Graphics.ImageDiff": "docs/Graphics/ImageDiff.md"
        }
    });
});

gulp.task("default", ["make-example"]);
