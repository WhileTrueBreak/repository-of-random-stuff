import requests,json
import xlsxwriter
import os

url = "https://api.warframe.market/v1/items"
result = requests.get(url)

items = result.json()
items = items["payload"]["items"]

book = xlsxwriter.Workbook("Warframe.xls")
sheet = book.add_worksheet()
sheet.write(0, 0, "name");
sheet.write(0, 1, "url name");
sheet.write(0, 2, "volume");
sheet.write(0, 3, "min_price");
sheet.write(0, 4, "max_price");
sheet.write(0, 5, "avg_price");
sheet.write(0, 6, "median");

for i in range(len(items)):
    item = items[i]
    
    os.system("cls")
    print(str(i+1)+" of "+str(len(items)))
    print(str(int((i+1)*100/len(items)))+"% | "+item["item_name"]+" ")
    
    sheet.write(i+1, 0, item["item_name"]);
    sheet.write(i+1, 1, item["url_name"]);
    
    url = "https://api.warframe.market/v1/items/"+item["url_name"]+"/statistics"
    result = requests.get(url)

    json = result.json()["payload"]["statistics_live"]["48hours"]
    if(len(json)-1>=0):
        json = json[len(json)-1]
        sheet.write(i+1, 2, json["volume"]);
        sheet.write(i+1, 3, json["min_price"]);
        sheet.write(i+1, 4, json["max_price"]);
        sheet.write(i+1, 5, json["avg_price"]);
        sheet.write(i+1, 6, json["median"]);

book.close()


##print(json[0])
##url = "https://api.warframe.market/v1/items/"+json[0]["url_name"]+"/statistics"
##result = requests.get(url)
##
##json = result.json()["payload"]["statistics_closed"]["48hours"]
##json = json[len(json)-1]
##print(json)
##
####for i in range(len(json)):
####    print(json[i])
##
##
##






























