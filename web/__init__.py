from flask import Flask

app = Flask(__name__, static_url_path="", static_folder="/Users/kostyaev/Pictures/images2/")
from web import views