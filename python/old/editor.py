# Copyright 2020 Yordan Ivanov
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import base64
import os

import vim
from rpc import RPC


class Editor():
    def __init__(self):
        self._window = None
        self._buffer = None
        self._server = None

    def _var(self, var, default=None):
        exists = int(vim.eval(f'exists("{var}")'))

        if not exists:
            return default

        return vim.eval(f"{var}")

    def _init_rpc(self):
        host = self._var("g:dbt_host", "127.0.0.1")
        port = self._var("g:dbt_port", "8580")
        path = self._var("g:dbt_path", "dbt")

        self._server = RPC(host, port, path)

    def _rpc(self):
        if self._server is None:
            self._init_rpc()

        return self._server

    def _create_pvreview(self):
        vim.command("vnew")
        self._window = vim.windows[-1]
        self._window.options["previewwindow"] = True

        self._buffer = self._window.buffer
        self._buffer.options["filetype"] = "sql"
        self._buffer.options["buftype"] = "nofile"
        self._buffer.options["buflisted"] = False
        self._buffer.options["swapfile"] = False

    def preview(self, content):
        if self._window is None or not self._window.valid:
            self._create_pvreview()

        self._buffer.options["modifiable"] = True
        self._buffer[:] = None
        self._buffer.append(content.split("\n"))
        self._buffer.options["modifiable"] = False

    def start_server(self):
        self._rpc().start_server()
        print("dbt RPC server started")

    def stop_server(self):
        self._rpc().stop_server()
        print("dbt RPC server stopped")

    def compile_buffer(self):
        buffer = vim.current.buffer
        content = "\n".join(buffer).encode("ascii")
        sql = base64.b64encode(content).decode("utf-8")
        name = os.path.basename(buffer.name)

        print("Compiling...")
        compiled = self._rpc().compile_sql(sql, name)

        self.preview(compiled)
