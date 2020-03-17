import argparse
import json
import time
import uuid
from urllib import request
from urllib.error import URLError
from subprocess import Popen


def parse_args():
    parser = argparse.ArgumentParser(description="dbt RPC middleware")

    parser.add_argument(
        "--host",
        type=str,
        help="The host of the dbt RPC server",
    )

    parser.add_argument(
        "--port",
        type=str,
        help="The port of the dbt RPC server",
    )

    parser.add_argument(
        "--method",
        type=str,
        help="The method th send to the dbt RPC server",
    )

    parser.add_argument(
        "--params",
        nargs='*',
        type=str,
        help="method params"
    )

    parser.add_argument(
        "--callback",
        type=str,
        help="The vim/Neovim callback to be called"
    )

    return parser.parse_args()


def get_args():
    args = parse_args()
    params = iter(args.params)

    return {
        "host": args.host,
        "port": args.port,
        "method": args.method,
        "params": dict(zip(params, params)),
        "callback": args.callback,
    }


def get_url(config):
    return "http://{host}:{port}/jsonrpc".format(
        host=config["host"],
        port=config["port"],
    )


def get_headers():
    return {
        "User-Agent": "dbt.vim",
        "Content-Type": "application/json",
        "Accept": "application/json",
    }


def get_payload(method, params):
    payload = json.dumps({
        "jsonrpc": "2.0",
        "method": method,
        "id": str(uuid.uuid1()),
        "params": params,
    })

    return str.encode(payload)


def exec_method(config):
    req = request.Request(
        url=get_url(config),
        method="POST",
        headers=get_headers(),
        data=get_payload(config["method"], config["params"]),
    )

    try:
        response = request.urlopen(req)
    except (ConnectionRefusedError, URLError):
        return {"error": "Server not running"}

    parsed = response.read().decode("utf-8")
    return json.loads(parsed).get("result")


def poll(request_token):
    while True:
        result = exec_method("poll", {
            "request_token": request_token,
            "logs": False
        })

        if result["state"] != "running":
            return result[0]

        time.sleep(1)


def start_server(config):
    if request("status").get("state") != "error":
        return

    Popen(config["params"]["path"].split() + [
        "rpc",
        "--host",
        config["host"],
        "--port",
        config["port"]
    ])

    while request("status").get("state") != "ready":
        time.sleep(1)


def main():
    args = get_args()
    result = {}

    if args["method"] == "start_server":
        start_server(args)
    else:
        response = exec_method(args["method"], args["params"])
        result = poll(response.get('request_token'))

    result["callback"] = args["callback"]

    print(result)


if __name__ == "__main__":
    main()
