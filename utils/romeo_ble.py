#! /usr/bin/env python3

from __future__ import print_function
from bluetooth.ble import DiscoveryService

from time import sleep
import sys
import binascii
from bluetooth.ble import GATTRequester, GATTResponse

SERVICE_UUID='0000dfb0-0000-1000-8000-00805f9b34fb'
SERIAL_PORT_UUID='0000dfb1-0000-1000-8000-00805f9b34fb'
COMMAND_UUID='0000dfb2-0000-1000-8000-00805f9b34fb'
MODEL_STRING_NUMBER_UUID='00002a24-0000-1000-8000-00805f9b34fb'
DEVICE_NAME_UUID='00002a00-0000-1000-8000-00805f9b34fb'

class Receive(GATTResponse):

    def on_response(self, data):
        print("Received: {}".format(data))

class Requester(GATTRequester):

      tx_bytes = 0

      def on_notification(self, handle, data):
          print("\n>>{}<<\n".format(data.decode('utf-8')))

      def write_data(self, data):
          print("Sending {} bytes: ".format(len(data)), end="")

          for d in data:
              print("{}".format(d), end="")
              sys.stdout.flush()
              self.write_by_handle(0x0025, str(d))

          print(" --> OK! {}".format(self.tx_bytes))

class Reader(object):
    def __init__(self, address):
        self.address = address
        self.requester = Requester(address, False)
        self.connect()
        self.get_device_name()
        self.get_model_name()

        print("Init done")

    def connect(self):
        print("Connecting to ", self.address, end='  ')
        sys.stdout.flush()

        self.requester.connect(True)
        print("OK!")

    def send(self, data):

        self.requester.write_data(bytes(data, 'utf-8'))

    def read(self):
        data = self.requester.read_by_handle(0x0028)
        print("Received {}".format(data))

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
        reader = Reader(bluno)
        reader.send("+++\r\n") 
        while True:
            reader.send("AT+FSM=?\r\n") 
            reader.send("A") 
            sleep(3.0)
            #reader.read()
            #for i in range(1,255):
                #self.requester.read_by_uuid_async(SERIAL_PORT_UUID, Receiver())
                #sleep(0.1)
                #reader.send(chr(i))
                #reader.read()

print("Done.")
