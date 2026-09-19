import 'dart:async';
import 'dart:convert';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';

class BLEManager {
  BLEManager._privateConstructor();
  static final BLEManager instance = BLEManager._privateConstructor();

  BluetoothDevice? _device;
  BluetoothCharacteristic? _rxCharacteristic;
  BluetoothCharacteristic? _txCharacteristic;

  bool connected = false;
  BluetoothDevice? lastDevice;

  // 🔔 Stream to notify UI about connection changes
  final _connectionController = StreamController<bool>.broadcast();
  Stream<bool> get connectionStream => _connectionController.stream;

  // Service + characteristic UUIDs (parehas sa Arduino)
  static const String SERVICE_UUID = "6E400001-B5A3-F393-E0A9-E50E24DCCA9E";
  static const String CHAR_TX = "6E400003-B5A3-F393-E0A9-E50E24DCCA9E"; // ESP32 → phone
  static const String CHAR_RX = "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"; // phone → ESP32

  Future<void> connect(BluetoothDevice device) async {
    _device = device;
    lastDevice = device;

    try {
      await _device!.connect(autoConnect: false);
    } catch (e) {
      if (e.toString().contains("already connected")) {
        print("Already connected");
      } else {
        print("Connection error: $e");
      }
    }

    // Listen for disconnects
    _device!.connectionState.listen((state) {
      if (state == BluetoothConnectionState.disconnected) {
        connected = false;
        _connectionController.add(false); // notify UI
        print("Device disconnected unexpectedly");
      }
    });

    // Discover services
    List<BluetoothService> services = await _device!.discoverServices();
    for (var s in services) {
      if (s.uuid.toString().toUpperCase() == SERVICE_UUID) {
        for (var c in s.characteristics) {
          final uuid = c.uuid.toString().toUpperCase();

          if (uuid == CHAR_TX) {
            _txCharacteristic = c;
            await c.setNotifyValue(true);
            c.value.listen((data) {
              final text = utf8.decode(data);
              print("ESP32 → $text");
            });
          }

          if (uuid == CHAR_RX) {
            _rxCharacteristic = c;
          }
        }
      }
    }

    // ✅ Basta naa ang RX, consider connected
    if (_rxCharacteristic != null) {
      connected = true;
      _connectionController.add(true); // notify UI
      print("BLE connected to ${_device!.name}");
    } else {
      connected = false;
      _connectionController.add(false);
      print("Failed: RX characteristic not found!");
    }
  }

  Future<void> send(String message) async {
    if (!connected) {
      print("❌ Device not connected!");
      return;
    }
    if (_rxCharacteristic == null) {
      print("❌ RX characteristic not found!");
      return;
    }
    final bytes = utf8.encode(message);
    try {
      await _rxCharacteristic!.write(bytes, withoutResponse: false);
      print("✅ You → $message");
    } catch (e) {
      print("❌ Failed to send: $e");
    }
  }

  Future<void> autoConnect() async {
    if (lastDevice != null) {
      await connect(lastDevice!);
    } else {
      print("No previously connected device found.");
    }
  }

  Future<void> disconnect() async {
    if (_device != null) {
      try {
        if (_txCharacteristic != null) {
          await _txCharacteristic!.setNotifyValue(false);
        }
        await _device!.disconnect();
      } catch (e) {
        print("Error during disconnect: $e");
      }
      connected = false;
      _connectionController.add(false); // notify UI
      _device = null;
      _rxCharacteristic = null;
      _txCharacteristic = null;
      print("Device disconnected");
    }
  }

  void dispose() {
    _connectionController.close();
  }
}
