import socket
from flask import Flask, render_template
from dataclasses import dataclass

app = Flask(__name__)

@dataclass
class Host:
    hostname: str
    ip: str
    
@dataclass
class Connection:
    host: Host
    port: int

def connect_host(connection: Connection) -> bool:
    if connection.host.hostname == "" or connection.host.ip == "":
        return False
    else:
        check_connection = socket.create_connection((connection.host.ip, connection.port))

        if check_connection == 0 :
            return True
        else:
            return False


@app.route('/')
def main():
    hostname = socket.gethostname()
    ip_address = socket.gethostbyname(hostname) 

    # Vérifier la connexion vers une hote.
    host = Host("google.com", "8.8.8.8")
    connection = Connection(host, 80)
    check_host = connect_host(connection)


    return render_template(
            'index.html',
             hostname=hostname,
             ip_address=ip_address,
             remote_connection=check_host,
             remote_port=80
             )


if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0', port=8080)
