import os
import shutil

# get all files from dir(have subdirectory file)
def get_files(dir_name):
    files = []
    for (dirpath,dirnames,filenames) in os.walk(dir_name):
        files.extend([dirpath + "\\" + f for f in filenames])
    return files

def read_file(file_name):
    data = ''
    with open(file_name) as f:
        data = f.read()
    return data

def write_file(file_name,data):
    with open(file_name,'w') as f:
        f.write(data)
