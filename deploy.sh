#!/bin/bash
# compile
coffee --compile static/js/*.coffee
lessc -x static/css/style.less static/css/style.css
jade view/*.jade

# compress
uglifyjs static/js/script.js --mangle --compress --screw-ie8 -o static/js/script.js
find . -name "*.pyc" -exec rm -fv {} \;
find . -name "*.wsgic" -exec rm -fv {} \;

echo "The files are ready to deploy."
