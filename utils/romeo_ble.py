#! /usr/bin/env python3

from __future__ import print_function
from bluetooth.ble import DiscoveryService
from bluetooth.ble import GATTRequester, GATTResponse

from time import sleep
import sys

from collections import defaultdict


def raw_data_to_list(data):
    return list(map(hex, map(ord, data)))


class Receive(GATTResponse):

    def on_response(self, data):
        print("Received: {}".format(data))


class Requester(GATTRequester):

    rx_buf = defaultdict(list)

    def on_notification(self, handle, data):
        ''' Prints handle and list of hex values received '''

        fields = raw_data_to_list(data)

        # First three bytes do not contain the data
        self.rx_buf[hex(handle)] += fields[3:]

    def flush_rx_buf(self):

        for handle, data in self.rx_buf.items():
            print("RX >> {}: {}".format(handle, data))

        self.rx_buf = defaultdict(list)

    def write_data(self, handle, data):
        print("TX << 0x{:04x}: [".format(handle), end="")

        for d in data:
            print("'0x{:02X}'".format(d), end=", ")
            sys.stdout.flush()
            self.write_by_handle(handle, chr(d))
        print("]")


class Bluno(object):
    ''' Bluno object '''

    SERVICE_UUID = '0000dfb0-0000-1000-8000-00805f9b34fb'
    SERIAL_PORT_UUID = '0000dfb1-0000-1000-8000-00805f9b34fb'
    COMMAND_UUID = '0000dfb2-0000-1000-8000-00805f9b34fb'
    MODEL_STRING_NUMBER_UUID = '00002a24-0000-1000-8000-00805f9b34fb'
    DEVICE_NAME_UUID = '00002a00-0000-1000-8000-00805f9b34fb'

    def __init__(self, address):
        self.address = address.strip()
        self.requester = Requester(address, False)
        self.connect()
        self.device_name = self.get_from_uuid(self.DEVICE_NAME_UUID)
        self.model_name = self.get_from_uuid(self.MODEL_STRING_NUMBER_UUID)

        self.serial_handle = self.handle_from_uuid(self.SERIAL_PORT_UUID)

        print("Connected to {self.device_name} \
              - {self.model_name} at {self.address} - \
              Serial handle: {self.serial_handle:04x}".format(self=self))

    def connect(self):
        print("Connecting to ", self.address, end='  ')
        sys.stdout.flush()

        self.requester.connect(True)
        print("OK!")

    def send(self, data):
        self.requester.write_data(self.serial_handle, bytes(data))
        sleep(0.1)
        self.requester.flush_rx_buf()

    def read(self):
        data = self.requester.read_by_uuid(self.SERIAL_PORT_UUID)
        print("Received {}".format(raw_data_to_list(data)))

    def handle_from_uuid(self, uuid):

        for char in self.requester.discover_characteristics():
            if char['uuid'] == uuid:
                return char['value_handle']

    def get_from_uuid(self, uuid):

        [data] = self.requester.read_by_uuid(uuid)

        try:
            return data.decode("utf-8")
        except AttributeError:
            return data


def get_bluno_addresses():

    service = DiscoveryService()
    devices = service.discover(2)

    addresses = [address for address, name in devices.items()
                 if name.startswith('Bluno')]

    return addresses


if __name__ == '__main__':

    for address in get_bluno_addresses():
        bluno = Bluno(address)
        while True:
            for i in range(0x00, 0x0f):
                bluno.send([i, i+1])

print("Done.")
