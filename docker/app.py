"""Tiny web server using only Python's standard library (no pip installs).
Listens on port 8080 and replies with a hello message plus the hostname,
so later we can SEE which container/pod answered us."""

import http.server
import socketserver
import socket

PORT = 8080


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-Type", "text/plain")
        self.end_headers()
        message = f"Hello AI ENGINEERS! From {socket.gethostname()}\n"
        self.wfile.write(message.encode())

with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"Serving on port {PORT}")
        httpd.serve_forever()