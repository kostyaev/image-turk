from flask import request, jsonify
from web import app
import os
import searchtools
import shutil
from config import *
import urllib2
from loggers import logger
import specific_engines
from flask import json

google_searcher = searchtools.query.GoogleWebSearch()
imagenet_searcher = specific_engines.ImagenetSearcher()
yandex_searcher = specific_engines.YandexSearcher()
bing_searcher = None
instagram_searcher = None
flickr_searcher = None

static_dir = u"/Users/dmitry/Pictures/"

@app.route("/ping", methods=["GET"])
def ping():
    return "ok"

def join(a,b):
    return os.path.join(static_dir, a, b).lstrip(static_dir)

def listdir(d):
    return os.listdir(os.path.join(static_dir, d))

def isdir(d):
    return os.path.isdir(os.path.join(static_dir, d))


@app.route("/api/dirs/<path:id>", methods=["GET"])
def get_dir_by_id(id):
    all_files = [join(id, f) for f in listdir(id)]
    child_dirs = [{'id': f, 'name': f.rsplit('/', 1)[1]} for f in all_files if isdir(f)]
    images = [{'id': f.rsplit('/', 1)[1], 'url': f} for f in all_files if f.lower().endswith('.jpg')]
    parent_dir_id = id.rstrip('/').rsplit('/', 1)[0]
    parent_dir_id = '' if parent_dir_id == id else parent_dir_id
    siblings_dirs = [{'id': join(parent_dir_id, f), 'name': f} for f in listdir(parent_dir_id) if isdir(join(parent_dir_id, f))]
    response = {'id': id, 'name': id.rstrip('/').split('/')[-1], 'images': images,
                'parent': parent_dir_id, 'children': child_dirs, 'siblings': siblings_dirs}
    return jsonify(response)

