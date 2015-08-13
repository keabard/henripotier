module.exports = (grunt) ->
    grunt.initConfig
        coffee:
            compile:
                files:
                    './webapp/bin/app.js': ['./webapp/src/**/*.coffee']

    grunt.loadNpmTasks 'grunt-contrib-coffee'

