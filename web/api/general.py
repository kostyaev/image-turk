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



def get_page_params(r):
    page, page_size = int(r.args.get('page', '1')), int(r.args.get('size', '30'))
    page = 0 if page < 1 else page
    return page_size, (page-1)*page_size


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

@app.route("/api/search", methods=["GET"])
def search():
    q = request.args.get('query')
    search_engine = request.args.get('source')

    limit, offset = get_page_params(request)

    if search_engine == 'google':
        searcher = google_searcher
    elif search_engine == 'flickr':
        global flickr_searcher
        if flickr_searcher is None:
            flickr_searcher = searchtools.query.FlickrAPISearch()
        searcher = flickr_searcher
    elif search_engine == 'bing':
        global bing_searcher
        if bing_searcher is None:
           bing_searcher = searchtools.query.BingAPISearch()
        searcher = bing_searcher
    elif search_engine == 'instagram':
        global instagram_searcher
        if instagram_searcher is None:
           instagram_searcher = specific_engines.InstagramSearcher()
        searcher = instagram_searcher
    elif search_engine == 'yandex':
        searcher = yandex_searcher
    else:
        searcher = imagenet_searcher

    try:
        images = searcher.query(q, num_results=offset+limit)[offset:offset+limit]
        images = [{'id': img['image_id'], 'url': img['url']} for img in images]
    except Exception as e:
        logger.info("Exception occurred {}", e.message)
        logger.exception(e)
        images = []

    return jsonify({"images": images})



# @app.route("/api/images", methods=["POST"])
# def add_image():
#     json = request.json
#     response = jsonify({})
#     if 'url' in json:
#         url = json['url']
#         id = json['image_id']
#         dir_id = json['dir_id']
#         if '.gif' not in url:
#             data = urllib2.urlopen(url).read()
#             if len(data) > 10000:
#                 with open(os.path.join(static_dir, dir_id) + '/' + id + ".jpg", 'w') as f:
#                     f.write(data)
#         else:
#             response.status_code = 400
#     else:
#         dir_name = json['dir']
#         if len(relative_path) > 0:
#             relative_path += '/'
#         path = os.path.join(static_dir, relative_path + dir_name)
#         if not os.path.exists(path):
#             os.makedirs(path)
#     return response
