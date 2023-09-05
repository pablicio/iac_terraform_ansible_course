#!/bin/bash
`git fetch 2>/dev/null`;

for i in `git diff --name-only main origin/main 2>/dev/null | egrep '\.(puml)$'`; do
  # generated images from .puml file
  echo $i;
  # `java -jar plantuml.jar $i`;

  # update or create strategy
  # aws s3 cp file.jpg s3://my-bucket/file.jpg

  # s3 store generated images?
  # curl -X PUT -T /path/to/local/file.jpg \
  # -H "x-amz-acl: public-read" \
  # -H "Content-Type: image/jpeg" \
  # "https://s3.amazonaws.com/your-bucket-name/file.jpg" \
  # -H "Authorization: AWS ACCESS_KEY_ID:SECRET_ACCESS_KEY"
done

## How to map the images?
## with db table??

## generate current folder structure and save in json
`rm map_folder.json 2> /dev/null`;
`python3 map_formatter.py >> map_folder.json`;