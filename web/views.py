from flask import Flask, request, jsonify
from flask_restful import Api
from flask import render_template
from web import app
from os import listdir
from os.path import join
import imsearchtools
import urllib

image_dir = '/Users/kostyaev/Pictures/images2/'

@app.route("/ping", methods=["GET"])
def ping():
    return "ok"

@app.route("/query/<keywords>", methods=["GET"])
def query(keywords):
    google_searcher = imsearchtools.query.GoogleWebSearch()
    images = google_searcher.query(keywords)
    return render_template("index.html",
                           title='Home',
                           images=images)


@app.route("/images", methods=["GET"])
def get_images():
    images =[f for f in listdir(image_dir) if (f.endswith(".jpg"))]
    return render_template("index.html",
                           title='Home',
                           images=images)


@app.route("/images", methods=["POST"])
def upload_image():
    js = request
    print request.json
    url = request.json['url']
    urllib.urlretrieve(url, image_dir + url.split('/')[-1])
    print url
    return "ok"

@app.route("/images/:id", methods=["DELETE"])
def delete_image():
    return "ok"