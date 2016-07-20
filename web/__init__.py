from flask import Flask
from config import *
from flask_cors import CORS


app = Flask(__name__, static_url_path="", static_folder=static_dir)
cors = CORS(app, resources={r"/api/*": {"origins": "*"}})


from web import views
from web.api import general