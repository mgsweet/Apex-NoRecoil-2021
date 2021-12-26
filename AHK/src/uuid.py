import uuid

with open ('input.txt', 'r' ) as f:
    content = f.read()

    new_uuid_str = 'global UUID = "' + uuid.uuid4().hex + '"'
    
    content_new = re.sub(r'^global UUID = "\s+"$', content, new_uuid_str)

    print(content_new)

    f.write(content_new)