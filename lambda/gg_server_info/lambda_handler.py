import json
import greengrasssdk
from threading import Timer
import socket
import platform

iot_client = greengrasssdk.client("iot-data")


def server_info():
    mqtt_topic = "$aws/things/clem2_gg_group_Core_Core/shadow/update"
    hostname = socket.gethostname()
    ip_addr = socket.gethostbyname(hostname)
    payload = {
        "state": {
            "reported": {
                "hostname": hostname,
                "ip": ip_addr,
                "system": platform.system(),
                "kernel": platform.release()
            }
        }}
    iot_client.publish(topic=mqtt_topic, payload=json.dumps(payload))
    Timer(1, server_info).start()


server_info()


def lambda_handler(event, context):
    return
