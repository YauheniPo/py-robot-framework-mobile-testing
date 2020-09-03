import os
import subprocess
import threading

from robot.api import logger


def run_command(cmd):
    p = subprocess.Popen(cmd, shell=True, cwd=os.getcwd())
    output, err = p.communicate()
    logger.info(f'output=${output}')
    logger.error(f'output=${err}') if err else None
    return output


def start_appium_server(appium_command):
    t = threading.Thread(target=run_command, args=(appium_command,))
    t.daemon = True
    t.start()
