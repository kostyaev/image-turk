from flask import Flask
from config import *

app = Flask(__name__, static_url_path="", static_folder=static_dir)
from web import views
from web.api import general