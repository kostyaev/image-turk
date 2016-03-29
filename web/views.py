from flask import request, jsonify
from flask import render_template
from web import app
import os
from os import listdir
from os.path import join
import imsearchtools
import urllib
import uuid
import shutil
from config import *

google_searcher = imsearchtools.query.GoogleWebSearch()
flickr_searcher = imsearchtools.query.FlickrAPISearch()


@app.route("/ping", methods=["GET"])
def ping():
    return "ok"

@app.route("/browse", defaults={'relative_path': ""})
@app.route("/browse/<path:relative_path>", methods=["GET"])
def list_dirs(relative_path):
    images = []
    dirs = []
    try:
        path = join(static_dir, relative_path)
        all_files = listdir(path)
        dirs = [unicode(f, "utf-8") if type(f) != unicode else f for f in all_files if os.path.isdir(join(path, f))]
        relative_path = "/" if relative_path == "" else "/" + relative_path + "/"
        images = [relative_path + f for f in all_files if f.endswith(".jpg") or f.endswith(".JPEG")]
    except Exception as e:
        print e
    return render_template("browse.html",
                           title='Browse',
                           dirs=dirs,
                           images=sorted(images),
                           total=len(images) + len(dirs))


@app.route("/browse", defaults={'relative_path': ''}, methods=["POST"])
@app.route("/browse/<path:relative_path>", methods=["POST"])
def query_page(relative_path):
    q = request.form['query']
    search_engine = request.form['engine']
    max = int(request.form['max'])
    skip = int(request.form['skip'])
    if search_engine == 'google':
        searcher = google_searcher
    else:
        searcher = flickr_searcher
    images = searcher.query(q, num_results=max)[skip:]
    return render_template("query.html",
                           title='Home',
                           images=images,
                           total=len(images))


@app.route("/browse", defaults={'relative_path': ''}, methods=["PUT"])
@app.route("/browse/<path:relative_path>", methods=["PUT"])
def add_item(relative_path):
    json = request.json
    response = jsonify({})
    if 'url' in json:
        url = json['url']
        relative_path = "/" if relative_path == "" else "/" + relative_path + "/"
        if '.gif' not in url:
            data = urllib.urlopen(url).read()
            if len(data) > 10000:
                with open(static_dir + relative_path + str(uuid.uuid4()) + ".jpg", 'w') as f:
                    f.write(data)
        else:
            response.status_code = 400
    else:
        dir_name = json['dir']
        if len(relative_path) > 0:
            relative_path += '/'
        path = os.path.join(static_dir, relative_path + dir_name)
        if not os.path.exists(path):
            os.makedirs(path)
    return response


@app.route("/browse", defaults={'relative_path': ''}, methods=["DELETE"])
@app.route("/browse/<path:relative_path>", methods=["DELETE"])
def remove_item(relative_path):
    json = request.json
    if 'img' in json:
        os.remove(static_dir + json['img'])
    elif 'dir' in json:
        dir_name = json['dir']
        relative_path = relative_path + "/" if relative_path != '' else relative_path
        path = static_dir + relative_path + dir_name
        shutil.rmtree(path)
    elif relative_path != '':
        dir_name = json['renameDir']
        old_path = static_dir + relative_path
        new_path = '/'.join((static_dir + relative_path).split('/')[:-1]) + '/' + dir_name
        os.rename(old_path, new_path)

    response = jsonify({})
    return response
