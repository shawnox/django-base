from os import path, environ

from dotenv import load_dotenv
from split_settings.tools import include


if path.exists(".env"):
    load_dotenv()

settings_to_load = ["common.py", "logging.py"]

if environ["ENV"] == "dev":
    settings_to_load.append("settings.dev.py")
elif environ["ENV"] == "prod":
    settings_to_load.append("settings.prod.py")

    if environ["DEPLOYMENT"] == "aws":  # Load AWS settings
        settings_to_load.append("settings.aws.py")
else:
    raise ValueError(f"Invalid environment: {environ['ENV']}")

include(*settings_to_load)
