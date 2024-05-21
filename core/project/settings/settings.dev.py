# SECURITY WARNING: keep the secret key used in production secret!
SECRET_KEY = "django-insecure-)qjer@#!z%2a7pdz8cfsgec_s_y^%i&*sc1o#)2qqd(=19#zrf"

# SECURITY WARNING: don't run with debug turned on in production!
DEBUG = True

LOGGING["formatters"]["colored"] = {  # type: ignore
    "()": "colorlog.ColoredFormatter",
    "format": "%(log_color)s%(asctime)s [%(levelname)s] %(name)s: %(message)s",
    "log_colors": {
        "DEBUG": "cyan",
        "INFO": "green",
        "WARNING": "yellow",
        "ERROR": "red",
        "CRITICAL": "red,bg_white",
    },
}
LOGGING["loggers"]["core"]["level"] = "DEBUG"  # type: ignore
LOGGING["handlers"]["console"]["level"] = "DEBUG"  # type: ignore
LOGGING["handlers"]["console"]["formatter"] = "colored"  # type: ignore
