import socket
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_geek():
    hostname = socket.gethostname()
    return '<h1>Message envoye par Flask deploye dans un conteneur Docker nomme : ' + hostname + ' </h1>'


if __name__ == "__main__":
    app.run(debug=True)
