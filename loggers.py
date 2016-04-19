from logging import config as _config
import logging
_config.fileConfig('logging.conf')

logger = logging.getLogger("ImageTurk")
