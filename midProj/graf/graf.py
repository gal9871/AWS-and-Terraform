import requests
import json
from requests.structures import CaseInsensitiveDict
import os
directory = 'dashboards'
for filename in os.listdir(directory):
    f = os.path.join(directory, filename)
    if os.path.isfile(f):
        print(f)
        db = open(f)
        data = json.load(db)
        db.close()
        headers = CaseInsensitiveDict()
        headers["Accept"] = "application/json"
        headers["Content-Type"] = "application/json"
        headers["Authorization"] = "Bearer eyJrIjoiY3NRbXZrU0w0MnNjbnBVYzFlbVNSUjBWcXlpdnVrYVQiLCJuIjoiZ3JhZiIsImlkIjoxfQ=="
        url = 'http://3.221.155.91:3000/api/dashboards/db'
        x = requests.post(url, json = data, headers = headers)

        print(x.text)
