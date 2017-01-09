#! /usr/bin/env python3

from __future__ import print_function

from bluetooth.ble import DiscoveryService
from bluetooth.ble import GATTRequester, GATTResponse
from collections import defaultdict
from time import sleep

import copy
import logging
import sys

logging.basicConfig(level=logging.DEBUG)

def raw_data_to_list(data):
    return list(map(ord, data))


def addresses_with_device_name(device_name):

    service = DiscoveryService()
    devices = service.discover(2)

    addresses = [address for address, name in devices.items()
                 if device_name in name]

    return addresses


class Requester(GATTRequester):

    rx_buf = defaultdict(list)

    def on_notification(self, handle, data):
        ''' Prints handle and list of hex values received '''

        fields = raw_data_to_list(data)

        # First three bytes do not contain the data
        self.rx_buf[hex(handle)] += fields[3:]

        logging.debug("RX >> {}: {}".format(hex(handle),
                                            list(map(hex, fields[3:]))))

    def read_data(self, handle):
        ''' Read and empty buffer of given handle '''

        data = bytes(self.rx_buf[hex(handle)])
        self.rx_buf[hex(handle)] = []

        return data

    def write_data(self, handle, data):
        ''' Write given list of values to given handle '''
        logging.debug("TX << 0x{:x}: {}".format(handle,
                                                [hex(d) for d in data]))
        self.write_by_handle(handle, bytes(data))


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
        self.connected = False
        self.device_name = ""
        self.model_name = ""
        self.serial_handle = 0x0

    def connect(self):
        ''' Connects to address stored in object '''
        logging.info("Connecting to {}".format(self.address))

        self.requester.connect(True)
        self.connected = True

        self.device_name = self._get_from_uuid(self.DEVICE_NAME_UUID)
        self.model_name = self._get_from_uuid(self.MODEL_STRING_NUMBER_UUID)

        self.serial_handle = self._handle_from_uuid(self.SERIAL_PORT_UUID)

        logging.debug("Connected to device: {}".format(self.device_name))
        logging.debug("              model: {}".format(self.model_name))
        logging.debug("            address: {}".format(self.address))
        logging.debug("      serial handle: 0x{:04x}".format(self.serial_handle))

    def send(self, data):
        ''' Send data to serial port of Bluno '''
        if not self.connected: self.connect()

        self.requester.write_data(self.serial_handle, bytes(data))

    def read(self):
        ''' Read all data received from serial connection '''

        return self.requester.read_data(self.serial_handle)

    def _handle_from_uuid(self, uuid):
        ''' Retrieve hex handle based based on uuid '''

        for char in self.requester.discover_characteristics():
            if char['uuid'] == uuid:
                return char['value_handle']

    def _get_from_uuid(self, uuid):

        [data] = self.requester.read_by_uuid(uuid)

        try:
            return data.decode("utf-8")
        except AttributeError:
            return data

def serial_test():
    msg = [i for i in range(0x00, 0x10)]
    bluno.send(msg)
    sleep(0.08)
    recv = bluno.read()
    logging.debug(list(map(hex, recv)))

    assert(len(msg) == len(recv))

    for rx, tx in zip(recv, msg):
        try:
            assert(rx == tx+1)
        except AssertionError:
            logging.error("RX {} != TX{} + 1".format(rx, tx))

def motor_test():

    for msg in range(0x00, 0x05):
        bluno.send([msg])
        sleep(3.0)

if __name__ == '__main__':

    for address in addresses_with_device_name('Bluno'):
        bluno = Bluno(address)
        while True:
            motor_test()

