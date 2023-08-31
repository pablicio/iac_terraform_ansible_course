import os, json, re

def validFiles(str):
    # Regex to check valid image file extension.
    regex = "([^\\s]+(\\.(?i)(puml|png))$)"
     
    # Compile the ReGex
    p = re.compile(regex)
 
    # If the string is empty
    # return false
    if (str == None):
        return False
 
    # Return if the string
    # matched the ReGex
    if(re.search(p, str)):
        return True
    else:
        return False

def path_to_dict(path):
    d = {'name': os.path.basename(path)}
    if os.path.isdir(path):
      d['type'] = "directory"
      d['items'] = [path_to_dict(os.path.join(path,x)) for x in os.listdir(path)]
    else:
      d['path'] = path[1:]
      d['type'] = "file"
    return d

output = path_to_dict('.')
print(json.dumps(output['items']))