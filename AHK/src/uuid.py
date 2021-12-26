import uuid

with open ('apexmaster.ahk') as f:
    content = f.read()

    new_uuid_str = 'global UUID = "' + uuid.uuid4().hex + '"'
    
    content_new = re.sub(r'^global UUID = "\s+"$', new_uuid_str, content)

    f.write(content_new)