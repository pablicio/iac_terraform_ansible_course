#!/bin/bash

## Generates diagrams of files modified in the last hour
for i in `find . -type f -name "*.puml" -mmin -60`; do
 `java -jar plantuml.jar $i`; 
done

## generate current folder structure and save in json
`rm map_folder.json 2> /dev/null`;
# `tree --dirsfirst --noreport -J -f | awk '!/jar|json|sh|py/' >> map_folder.json`;
`python3 map_formatter.py >> map_folder.json`; 