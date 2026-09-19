import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:esp32_ble_app/ble_man.dart'; // ✅ Import BLEManager

void main() => runApp(const MyApp());

const String ESP_DEVICE_NAME = "ESP32_BLE";
final Guid SERVICE_GUID = Guid("6E400001-B5A3-F393-E0A9-E50E24DCCA9E");
final Guid TX_CHAR = Guid("6E400003-B5A3-F393-E0A9-E50E24DCCA9E");
final Guid RX_CHAR = Guid("6E400002-B5A3-F393-E0A9-E50E24DCCA9E");

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP32 BLE Demo',
      home: const BleHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BleHomePage extends StatefulWidget {
  const BleHomePage({super.key});
  @override
  State<BleHomePage> createState() => _BleHomePageState();
}

class _BleHomePageState extends State<BleHomePage> {
  final List<ScanResult> _scanResults = [];
  final List<String> _log = [];
  StreamSubscription<List<ScanResult>>? _scanSub;
  bool _scanning = false;

  @override
  void initState() {
    super.initState();
    _ensurePermissions();
  }

  Future<void> _ensurePermissions() async {
    if (Platform.isAndroid) {
      await Permission.locationWhenInUse.request();
      try {
        if (await Permission.bluetoothScan.isDenied) {
          await Permission.bluetoothScan.request();
        }
        if (await Permission.bluetoothConnect.isDenied) {
          await Permission.bluetoothConnect.request();
        }
      } catch (e) {
        // ignore if not available on older devices
      }
    }
  }

  void _startScan() async {
    setState(() {
      _scanResults.clear();
      _scanning = true;
    });
    await _ensurePermissions();
    FlutterBluePlus.stopScan();
    FlutterBluePlus.startScan(timeout: const Duration(seconds: 4));

    _scanSub = FlutterBluePlus.scanResults.listen((results) {
      setState(() {
        _scanResults.clear();
        _scanResults.addAll(results);
      });
    });

    FlutterBluePlus.isScanning.listen((scanning) {
      setState(() => _scanning = scanning);
    });
  }

  Future<void> _connect(ScanResult r) async {
    _logAdd("Connecting to ${r.device.name} (${r.device.id})...");
    try {
      // ✅ Connect using BLEManager singleton
      await BLEManager.instance.connect(r.device);
      _logAdd("Connected to ${r.device.name}");
      setState(() {});
      // Optional: Pop back to main screen if you want
      Navigator.pop(context, r.device);
    } catch (e) {
      _logAdd("Connection failed: $e");
    }
  }


  void _logAdd(String s) {
    setState(() => _log.insert(0, s));
  }

  @override
  void dispose() {
    _scanSub?.cancel();
    super.dispose();
  }

  Widget _buildDeviceTile(ScanResult r) {
    return ListTile(
      title: Text(r.device.name.isNotEmpty ? r.device.name : r.device.id.toString()),
      subtitle: Text(r.advertisementData.localName),
      trailing: ElevatedButton(
        child: const Text("Connect"),
        onPressed: () => _connect(r),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESP32 BLE Demo'),
        actions: [
          IconButton(
            icon: _scanning ? const Icon(Icons.stop) : const Icon(Icons.search),
            onPressed: _scanning ? () => FlutterBluePlus.stopScan() : _startScan,
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: _scanResults.isEmpty
                ? const Center(child: Text("No devices found. Press search."))
                : ListView(children: _scanResults.map(_buildDeviceTile).toList()),
          ),
          const Divider(),
          SizedBox(
            height: 160,
            child: _log.isEmpty
                ? const Center(child: Text("No messages yet."))
                : ListView(children: _log.map((s) => Text(s)).toList()),
          ),
        ],
      ),
    );
  }
}
