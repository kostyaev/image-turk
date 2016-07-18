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


@app.route("/ping", methods=["GET"])
def ping():
    return "ok"

def join(a,b):
    return os.path.join(static_dir, a, b).replace(static_dir, '')

def listdir(d):
    return os.listdir(os.path.join(static_dir, d))

def isdir(d):
    return os.path.isdir(os.path.join(static_dir, d))


@app.route("/api/dirs", defaults={'path_id': ""})
@app.route("/api/dirs/", defaults={'path_id': ""})
@app.route("/api/dirs/<path:path_id>", methods=["GET"])
def get_dir_by_id(path_id):
    path_id=path_id.rstrip('/')
    all_files = [join(path_id, f) for f in listdir(path_id)]
    child_dirs = [{'id': f, 'name': f.rsplit('/', 1)[-1]} for f in all_files if isdir(f)]
    images = [{'id': f.rsplit('/', 1)[-1], 'url': f} for f in all_files if f.lower().endswith('.jpg')]
    parent_dir_id = path_id.rstrip('/').rsplit('/', 1)[0]
    parent_dir_id = '' if parent_dir_id == path_id else parent_dir_id
    siblings_dirs = [{'id': join(parent_dir_id, f), 'name': f} for f in listdir(parent_dir_id) if isdir(join(parent_dir_id, f))]
    response = {'id': path_id, 'name': path_id.rstrip('/').split('/')[-1], 'images': images,
                'parent': parent_dir_id, 'children': child_dirs, 'siblings': siblings_dirs}
    return jsonify(response)