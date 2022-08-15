import sys,os
from PIL import Image
import praw
import urllib.request
import ctypes

file = "images/"
if not os.path.exists(file):
    print("Creating folder...")
    os.mkdir(file)
print("Getting posts...")
reddit = praw.Reddit('bot1', user_agent='wallpaperscraper1')
images = []
subreddit = reddit.subreddit("wallpaper")
hot = subreddit.hot(limit=10)
for submission in hot:
    print()
    title = submission.title
    url = submission.url
    print("Getting image from "+url)
    if "gallery" in url:
        for item in submission.gallery_data["items"]:
            media_id = item["media_id"]
            imgtype = '.'+submission.media_metadata[media_id]["m"].split("/")[-1]
            media_file = media_id+imgtype
            imgurl = 'https://i.redd.it/'+media_file
            urllib.request.urlretrieve(imgurl,file+media_file)
            images.append(file+media_file)
        pass
    else:
        urllib.request.urlretrieve(url, file+url.split("/")[-1])
        images.append(file+url.split("/")[-1])
print("Finding image...")
for image in images:
    img = Image.open(image)
    width,height = img.size
    ratio = float(width)/height
    if ratio == 1920/1080 and width >= 1920:
        path = os.path.abspath(os.path.expanduser(os.path.expandvars(image)))
        ctypes.windll.user32.SystemParametersInfoW(20, 0, path , 0)
        break
for image in images:
    try:
        os.remove(image)
        print("removed {0}".format(image))
    except:
        print("could not remove {0}".format(image))
        pass
sys.exit()
