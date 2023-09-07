#!/usr/bin/env python3

from http.server import BaseHTTPRequestHandler, HTTPServer, SimpleHTTPRequestHandler
import socketserver
import os


def main():
    host_name = "0.0.0.0"
    server_port = 8080

    os.chdir("coreos")

    handler = SimpleHTTPRequestHandler
    handler.extensions_map.update({'.webapp': 'application/x-web-app-manifest+json',})
    socketserver.TCPServer.allow_reuse_address=True
    web_server = HTTPServer((host_name, server_port), handler)
    print("Server started http://%s:%s" % (host_name, server_port))

    try:
        web_server.serve_forever()
    except KeyboardInterrupt:
        pass

    web_server.server_close()
    print("Server stopped.")


if __name__ == "__main__":
    main()

