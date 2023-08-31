import os

def list_files(startpath):
    for root, dirs, files in os.walk(startpath):
        dir_content = []
        for dir in dirs:
            go_inside = os.path.join(startpath, dir)
            dir_content.append(list_files(go_inside))
        files_lst = []
        for f in files:
            files_lst.append(f)
        return {'name': root, 'files': files_lst, 'items': dir_content}

output = list_files('.')
print(output)
