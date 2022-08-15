import requests,json
import xlsxwriter
import os

def getResult(url):
    return requests.get(url)
def postResult(url, payload):
    return requests.post(url, data=payload)

payload = dict(key1="accept: application/json", key2="Content-Type: application/json", key3="{\"auth_type\":\"header\",\"email\":\"jeff.jc2003@gmail.com\",\"password\":\"wxl000795\",\"device_id\":\"pc\"}")
print(payload)
result = postResult("https://api.warframe.market/v1/auth/restore", payload)
print(result.json())
