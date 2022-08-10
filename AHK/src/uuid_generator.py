import uuid
import re

def updateUUID(filename):
    with open(filename, "r") as f:
        content = f.read()

    new_uuid_str = 'global UUID := "' + uuid.uuid4().hex + '"'

    content_new = re.sub('global UUID := ".+"', new_uuid_str, content)

    with open(filename, "w") as f:
        f.write(content_new)


if __name__ == '__main__':
    updateUUID('gui.ahk')
    updateUUID('apexmaster.ahk')
    input("Done! Press enter to exit ;)") # to let people know the script is actually done...


