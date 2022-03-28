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
        headers["Authorization"] = "Bearer eyJrIjoidm1OM1dmN2VGSWhLZ0c5ODFEQ2oyUmNjYVRoUDZqeUsiLCJuIjoiamoiLCJpZCI6MX0="
        url = 'http://app-lb-939330077.us-east-1.elb.amazonaws.com:3000/api/dashboards/db'
        x = requests.post(url, json = data, headers = headers)

        print(x.text)
