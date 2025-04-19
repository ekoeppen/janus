#!/bin/bash

pushd ..
dirs="."
find $dirs -type d | xargs -I % mkdir -p docs/content/%
find . -name '*.f[ts]' | \
  xargs -I % sh -c "sed 's/^\([^\]\)/    \1/;s/\\\ //;s/\\\//;s/    include \(.*\)/[\1](.\/\1.md)\\n/' % >docs/content/%.md"
popd
