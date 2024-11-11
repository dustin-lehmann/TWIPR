import extensions.gui.nodejs_gui.nodejs_gui as gui
import subprocess
import sys


def main():
    if (3, 10) <= sys.version_info < (3, 12):
        print("Python version is compatible.")
    else:
        print("Incompatible Python version detected. Please use Python 3.10 or 3.11.")
    # Install all required packages
    try:
        # Run pip install with requirements.txt
        subprocess.check_call([sys.executable, "-m", "pip", "install", "-r", "requirements.txt"])
        print("All required packages have been installed.")
    except subprocess.CalledProcessError as e:
        print("An error occurred while installing packages.")
        print(e)

    # Install the GUI
    gui.install()


if __name__ == '__main__':
    main()
