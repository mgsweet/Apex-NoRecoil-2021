import uuid
import re

def updateUUID(filename, new_uuid):
    with open(filename, "r") as f:
        content = f.read()

    new_uuid_str = 'global UUID := "' + new_uuid + '"'

    content_new = re.sub('global UUID := ".+"', new_uuid_str, content)

    with open(filename, "w") as f:
        f.write(content_new)


if __name__ == '__main__':
    new_uuid = uuid.uuid4().hex
    
    updateUUID('gui.ahk', new_uuid)
    updateUUID('apexmaster.ahk', new_uuid)
    updateUUID('green.ahk', new_uuid)
    input("Done! Press enter to exit ;)") # to let people know the script is actually done...


