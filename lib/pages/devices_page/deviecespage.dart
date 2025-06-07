import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:final_project/pages/account_page/widgets/alertmassege.dart';

class DevicesPage extends StatefulWidget {
  const DevicesPage({super.key});

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  List<BluetoothDevice> _devicesList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _initializeBluetooth();
    _listenToBluetoothChanges();
  }

  Future<void> _initializeBluetooth() async {
    try {
      final state = await FlutterBluetoothSerial.instance.state;
      setState(() => _bluetoothState = state);
      if (state == BluetoothState.STATE_ON) {
        await _getPairedDevices();
      }
    } catch (e) {
      debugPrint('Error initializing Bluetooth: $e');
    }
  }

  void _listenToBluetoothChanges() {
    try {
      FlutterBluetoothSerial.instance.onStateChanged().listen((BluetoothState state) {
        try {
          setState(() => _bluetoothState = state);
          if (state == BluetoothState.STATE_ON) {
            _getPairedDevices();
          } else {
            setState(() => _devicesList.clear());
          }
        } catch (e) {
          debugPrint('Error handling Bluetooth state change: $e');
        }
      });
    } catch (e) {
      debugPrint('Error setting Bluetooth listener: $e');
    }
  }

  Future<void> _getPairedDevices() async {
    setState(() => _isLoading = true);
    try {
      final devices = await FlutterBluetoothSerial.instance.getBondedDevices();
      setState(() => _devicesList = devices);
    } catch (e) {
      debugPrint('Error getting paired devices: $e');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _enableBluetooth() async {
    try {
      final bool? enabled = await FlutterBluetoothSerial.instance.requestEnable();
      if (enabled == true) {
        await _getPairedDevices();
      }
    } catch (e) {
      debugPrint('Error enabling Bluetooth: $e');
    }
  }

  void _onAddDevicePressed() {
    try {
      if (_bluetoothState == BluetoothState.STATE_OFF) {
        showDialog(
          context: context,
          builder: (context) => Alertmassege(
            titeltext: "Turn on Bluetooth",
            contenttext: "To connect devices, you need to turn on your phone’s Bluetooth.",
            button1: "Cancel",
            button2: "Turn On",
            onConfirm: () async {
              Navigator.of(context).pop();
              await _enableBluetooth();
            },
          ),
        );
      } else {
        _getPairedDevices();
      }
    } catch (e) {
      debugPrint('Error on add device pressed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Row(
              children: const [
                Spacer(),
                Icon(Icons.add, size: 30),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              "Devices",
              style: TextStyle(fontSize: 42, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 2,
              child: ListTile(
                title: const Text(
                  "My Devices",
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                ),
                subtitle: const Text("Add devices to be controlled by the app."),
                trailing: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFF39B579),
                  ),
                  onPressed: _onAddDevicePressed,
                  child: const Text(
                    "Add Device",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _devicesList.isEmpty
                      ? const Center(child: Text("No paired devices found."))
                      : ListView.builder(
                          itemCount: _devicesList.length,
                          itemBuilder: (context, index) {
                            final device = _devicesList[index];
                            return Card(
                              elevation: 1,
                              child: ListTile(
                                leading: const Icon(Icons.devices),
                                title: Text(device.name ?? "Unknown Device"),
                                subtitle: Text(device.address),
                                onTap: () {
                                  try {
                                    // Handle device tap logic here
                                  } catch (e) {
                                    debugPrint("Error on device tap: $e");
                                  }
                                },
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}