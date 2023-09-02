#!/bin/bash

## Generates diagrams of files modified in the last hour
for i in `find . -type f -name "*.puml" -mmin -1`; do
 `java -jar plantuml.jar $i`; 
done

## Generates diagramsfrom get last sended git files
# for i in `python tests.py`; do
#   echo $i
# #  `java -jar plantuml.jar $i`; 
# done

## generate current folder structure and save in json
# `rm map_folder.json 2> /dev/null`;
# `python3 map_formatter.py >> map_folder.json`;