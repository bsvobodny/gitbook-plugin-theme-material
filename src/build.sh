#! /bin/bash
pushd $(dirname "${0}") > /dev/null
DIR=$(pwd -L)
echo $DIR
popd > /dev/null

# Cleanup folder
echo Cleanup folder
rm -rf $DIR/../_assets

# Recreate folder
echo Recreate folder
mkdir -p $DIR/../_assets/website/
mkdir -p $DIR/../_assets/ebook/

# Compile JS
echo Compile JS
browserify $DIR/js/core/index.js  | uglifyjs -mc > $DIR/../_assets/website/gitbook.js
browserify $DIR/js/theme/index.js | uglifyjs -mc > $DIR/../_assets/website/theme.js
# echo '\n/*Willin*/' >> $DIR/../_assets/website/gitbook.js
# uglifyjs $DIR/../node_modules/materialize-css/bin/materialize.js >> $DIR/../_assets/website/gitbook.js

# Compile Website CSS
echo Compile Website CSS
# lessc -clean-css less/website.less _assets/website/style.css
lessc -clean-css $DIR/material/css/main.less $DIR/../_assets/website/style.css

# Compile eBook CSS
echo Compile eBook CSS
lessc -clean-css $DIR/less/ebook.less $DIR/../_assets/ebook/ebook.css
lessc -clean-css $DIR/less/pdf.less $DIR/../_assets/ebook/pdf.css
lessc -clean-css $DIR/less/mobi.less $DIR/../_assets/ebook/mobi.css
lessc -clean-css $DIR/less/epub.less $DIR/../_assets/ebook/epub.css

# Copy fonts
echo Copy fonts
mkdir -p $DIR/../_assets/website/fonts
cp -R $DIR/material/fonts/ $DIR/../_assets/website/fonts/
cp -R $DIR/../node_modules/materialize-css/fonts/ $DIR/../_assets/website/fonts/

# Copy icons
echo Copy icons
mkdir -p $DIR/../_assets/website/images
cp $DIR/../node_modules/gitbook-logos/output/favicon.ico $DIR/../_assets/website/images/
cp $DIR/../node_modules/gitbook-logos/output/apple-touch-icon-152.png $DIR/../_assets/website/images/apple-touch-icon-precomposed-152.png
