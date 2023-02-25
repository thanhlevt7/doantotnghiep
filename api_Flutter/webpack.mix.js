const mix = require("laravel-mix");

/*
 |--------------------------------------------------------------------------
 | Mix Asset Management
 |--------------------------------------------------------------------------
 |
 | Mix provides a clean, fluent API for defining some Webpack build steps
 | for your Laravel application. By default, we are compiling the Sass
 | file for the application as well as bundling up all the JS files.
 |
 */

<<<<<<< HEAD
mix.js('resources/js/app.js', 'public/js')
    .vue()
    .sass('resources/sass/app.scss', 'public/css');

 mix.copyDirectory('resources/backend','public/backend');
=======
// mix.js('resources/js/app.js', 'public/js')
//     .vue()
//     .sass('resources/sass/app.scss', 'public/css');
mix.copyDirectory("resources/backend", "public/backend");
mix.copyDirectory("resources/frontend", "public/frontend");
>>>>>>> e0b6588f1c82003be5eda2c1fd2cd9cf038b75aa
