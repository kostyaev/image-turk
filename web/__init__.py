from flask import Flask

app = Flask(__name__, static_url_path="", static_folder="/opt/storage2/custom_dataset/images/")
from web import views