#!/bin/bash

echo "Making new tags"
ctags -R --language-force=c --exclude=.git --exclude=build --exclude=data_measurement_time --exclude=linker --exclude=macros
