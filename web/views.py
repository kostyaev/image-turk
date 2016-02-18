from flask import Flask, request, jsonify
from flask_restful import Api
from flask import render_template
from web import app
import os
from os import listdir
from os.path import join
import imsearchtools
import urllib
import uuid

image_dir = '/Users/kostyaev/Pictures/images2/'
google_searcher = imsearchtools.query.GoogleWebSearch()


@app.route("/ping", methods=["GET"])
def ping():
    return "ok"

@app.route("/query/<keywords>", methods=["GET"])
def query(keywords):
    images = google_searcher.query(keywords)
    return render_template("query.html",
                           title='Home',
                           images=images)


@app.route("/images", methods=["GET"])
def get_images():
    images =[f for f in listdir(image_dir) if (f.endswith(".jpg"))]
    return render_template("images.html",
                           title='Home',
                           images=images)


@app.route("/images", methods=["POST"])
def upload_image():
    url = request.json['url']
    response = jsonify({})
    if '.gif' not in url:
        data = urllib.urlopen(url).read()
        if len(data) > 10000:
            with open(image_dir + str(uuid.uuid4()) + ".jpg", 'w') as f:
                f.write(data)
    else:
        response.status_code = 400
    return response

@app.route("/images/:id", methods=["DELETE"])
def delete_image():
    return "ok"

@app.route("/browse", defaults={'relative_path': ""})
@app.route("/browse/<relative_path>", methods=["GET"])
def list_dirs(relative_path):
    path = join(image_dir, relative_path)
    all_files = listdir(path)
    dirs = [f for f in all_files if os.path.isdir(join(path, f))]
    relative_path = "/" if relative_path == "" else "/" + relative_path + "/"
    images = [relative_path + f for f in all_files if f.endswith(".jpg")]
    return render_template("index.html",
                           title='Browse',
                           dirs=dirs,
                           images=images)


