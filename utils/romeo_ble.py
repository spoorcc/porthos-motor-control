#! /usr/bin/env python3

from __future__ import print_function
from bluetooth.ble import DiscoveryService

from time import sleep
import sys
import copy
import binascii
from bluetooth.ble import GATTRequester, GATTResponse

SERVICE_UUID='0000dfb0-0000-1000-8000-00805f9b34fb'
SERIAL_PORT_UUID='0000dfb1-0000-1000-8000-00805f9b34fb'
COMMAND_UUID='0000dfb2-0000-1000-8000-00805f9b34fb'
MODEL_STRING_NUMBER_UUID='00002a24-0000-1000-8000-00805f9b34fb'
DEVICE_NAME_UUID='00002a00-0000-1000-8000-00805f9b34fb'

sys.settrace

def raw_data_to_list(data):
    return list(map(hex, map(ord, data)))

class Receive(GATTResponse):

    def on_response(self, data):
        print("Received: {}".format(data))

class Requester(GATTRequester):

      tx_bytes = 0

      def on_notification(self, handle, data):
          ''' Prints handle and list of hex values received '''

          fields = raw_data_to_list(data)
          print(">>0x{:04x} : {}<<".format(handle, fields))

      def write_data(self, handle, data):
          print("Sending {} bytes to {}: ".format(len(data), handle), end="")

          for d in data:
              print("0x{:02X}".format(d), end="")
              sys.stdout.flush()
              self.write_by_handle(handle, chr(d))

          print(" --> OK!")

class Reader(object):
    def __init__(self, address):
        self.address = address
        self.requester = Requester(address, False)
        self.connect()
        self.device_name = self.get_device_name()
        self.model_name = self.get_model_name()

        self.serial_handle = self.handle_from_uuid(SERIAL_PORT_UUID)

        print("Connected to {self.device_name} - {self.model_name} at {self.address} - Serial handle: {self.serial_handle:04x}".format(self=self))

    def connect(self):
        print("Connecting to ", self.address, end='  ')
        sys.stdout.flush()

        self.requester.connect(True)
        print("OK!")

    def handle_from_uuid(self, uuid):

        for char in self.requester.discover_characteristics():
            if char['uuid'] == uuid:
                return char['value_handle']

    def send(self, data):
        self.requester.write_data(self.serial_handle, bytes(data))

    def read(self):
        #data = self.requester.read_by_handle(0x0028)
        data = self.requester.read_by_uuid(SERIAL_PORT_UUID)
        print("Received {}".format(raw_data_to_list(data)))

    def get_device_name(self):
        return self.get_from_uuid(DEVICE_NAME_UUID)

    def get_model_name(self):
        return self.get_from_uuid(MODEL_STRING_NUMBER_UUID)

    def get_from_uuid(self, uuid):

        [data] = self.requester.read_by_uuid(uuid)

        try:
            return data.decode("utf-8")
        except AttributeError:
            return data

def get_bluno_addresses():

    service = DiscoveryService()
    devices = service.discover(2)

    addresses = [address for address, name in devices.items() if name.startswith('Bluno')]

    return addresses

if __name__ == '__main__':

    for bluno in get_bluno_addresses():
        reader = Reader(bluno)
        while True:
            sleep(0.5)
            for i in range(0x00, 0x0f):
                sleep(1.5)
                reader.send([i])

print("Done.")
