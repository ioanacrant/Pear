from aylienapiclient import textapi
from bs4 import BeautifulSoup
import requests
from urllib2 import urlopen
from flask import Flask, request
from flask.ext.restful import Resource, Api
import json
import os
from pprint import pprint

app = Flask(__name__)
api = Api(app)

dataSet = {"news": []}

#Location of articles -- for now, tech crunch
source_url = "http://www.techcrunch.com/popular"

#aylien api client username and key
client = textapi.Client("8e6fd4b7", "596bdf877a7e06c5ba5d051b15a0733b")

#Gets source url to be readable as BeautifulSoup
def make_soup(url):
	html = requests.get(url).text
	return BeautifulSoup(html)

#Gets all popular articles form tech crunch when called
def get_category_links(section_url):
	soup = make_soup(section_url)
	loc = soup.find("ul", "river lc-padding")
	links = [dd.a["href"] for dd in loc.findAll("h2")]
	return links

# Returns article title
def get_title(url):
	soup = make_soup(url)
	loc = soup.find("title")
	loc = str(loc)
	return loc[7:loc.index("|")]

def get_img(url):
	soup = make_soup(url)
	loc = soup.find("img", "")
	loc = str(loc)

	#A really bashy way of handling the soup line just to get the image url
	for i in range (3):
		quoteIndex = loc.index('"')
		loc = loc[quoteIndex+1:]
	loc = loc[:loc.rfind('"')]

	return loc

urls = get_category_links(source_url)[0:3]

def createDataSet():
	for url in urls:
		summary = client.Summarize({"url": url, "sentences_number": 2}) #Gets 3 sentence summary using API
		dataStruct = {"title": get_title(url), "sentences": summary["sentences"], "image": get_img(url), "url": url}
		dataSet["news"].append(dataStruct)

createDataSet()

class GetData (Resource):
	def get(self):
		DSString=str(dataSet)
		DSString.replace("{","[")
		DSString.replace("}","]")
		return json.dumps(DSString)

api.add_resource(GetData, "/")

if __name__ == "__main__":
	port = int(os.environ.get("PORT", 5000))
	app.run(host = "0.0.0.0", port = port)

