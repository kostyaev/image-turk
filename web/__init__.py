from flask import Flask, Blueprint
from config import *

app = Flask(__name__, static_url_path="/viewer", static_folder=static_dir)

blueprint = Blueprint('site', __name__, static_folder='static/site')
app.register_blueprint(blueprint)

from web import views