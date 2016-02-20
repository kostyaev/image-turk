from pyhocon import ConfigFactory

conf = ConfigFactory.parse_file("application.conf")

static_dir = conf.get("static_dir")
