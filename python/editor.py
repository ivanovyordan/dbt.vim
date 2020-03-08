import base64
import os

import vim
from rpc import RPC


class Editor():
    def __init__(self):
        self._window = None
        self._buffer = None
        self._rpc = None

    def rpc(self):
        if self._rpc is None:
            host = "0.0.0.0"
            port = "8580"
            self._rpc = RPC(host, port)

        return self._rpc

    def preview(self, content):
        if self._window is None or not self._window.valid:
            vim.command("vnew")
            self._window = vim.windows[-1]
            self._buffer = self._window.buffer
            self._buffer.options["ft"] = "sql"

        self._buffer.options["modifiable"] = True
        self._buffer[:] = None
        self._buffer.append(content.split("\n"))
        self._buffer.options["modifiable"] = False

    def compile_buffer(self):
        buffer = vim.current.buffer
        content = "\n".join(buffer).encode("ascii")
        sql = base64.b64encode(content).decode("utf-8")
        name = os.path.basename(buffer.name)

        compiled = self.rpc().compile_sql(sql, name)

        self.preview(compiled)
