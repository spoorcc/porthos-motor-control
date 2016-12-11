#! /usr/bin/env python3

from __future__ import print_function
from bluetooth.ble import DiscoveryService


import sys
from bluetooth.ble import GATTRequester

SERIAL_PORT_UUID='0000dfb1-0000-1000-8000-00805f9b34fb'
COMMAND_UUID='0000dfb2-0000-1000-8000-00805f9b34fb'
MODEL_STRING_NUMBER_UUID='00002a24-0000-1000-8000-00805f9b34fb'
DEVICE_NAME_UUID='00002a00-0000-1000-8000-00805f9b34fb'

class Reader(object):
    def __init__(self, address):
        self.address = address
        self.requester = GATTRequester(address, False)
        self.connect()
        self.get_device_name()
        self.get_model_name()

    def connect(self):
        print("Connecting to ", self.address, end='  ')
        sys.stdout.flush()

        self.requester.connect(True)
        print("OK!")

    def get_device_name(self):

        [data] = self.requester.read_by_uuid(DEVICE_NAME_UUID)

        try:
            print("Device name: " + data.decode("utf-8"))
        except AttributeError:
            print("Device name: " + data)

    def get_model_name(self):

        [data] = self.requester.read_by_uuid(MODEL_STRING_NUMBER_UUID)

        try:
            print("Model: " + data.decode("utf-8"))
        except AttributeError:
            print("Model: " + data)

def get_bluno_addresses():

    service = DiscoveryService()
    devices = service.discover(2)

    addresses = [address for address, name in devices.items() if name.startswith('Bluno')]

    return addresses

if __name__ == '__main__':

    for bluno in get_bluno_addresses():
        Reader(bluno)

print("Done.")
