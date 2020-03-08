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

import json
import uuid
import time

from urllib import request


class RPC():
    def __init__(self, host, port):
        self._server_url = f"http://{host}:{port}/jsonrpc"
        self._headers = {
            "User-Agent": "dbt.vim",
            "Content-Type": "application/json",
            "Accept": "application/json",
        }

    def _payload(self, method, params):
        payload = json.dumps({
            "jsonrpc": "2.0",
            "method": method,
            "id": str(uuid.uuid1()),
            "params": params
        })

        return str.encode(payload)

    def _request(self, method, params):
        req = request.Request(
            url=self._server_url,
            method='POST',
            headers=self._headers,
            data=self._payload(method, params),)

        response = request.urlopen(req).read().decode("utf-8")

        return json.loads(response).get("result")

    def _poll(self, request_token):
        completed = False

        while not completed:
            result = self._request("poll", {
                "request_token": request_token,
                "logs": False
            })

            completed = result["state"] != "running"
            if not completed:
                time.sleep(1)

        return result

    def compile_sql(self, sql, name):
        response = self._request("compile_sql", {"sql": sql, "name": name})
        result = self._poll(response.get('request_token'))

        return result["results"][0]["compiled_sql"]
