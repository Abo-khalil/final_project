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

  @override
  void initState() {
    super.initState();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
      if (state == BluetoothState.STATE_ON) {
        _getPairedDevices();
      }
    });

    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;
      });
      if (state == BluetoothState.STATE_ON) {
        _getPairedDevices();
      } else {
        setState(() {
          _devicesList.clear();
        });
      }
    });
  }

  Future<void> _getPairedDevices() async {
    List<BluetoothDevice> devices = [];
    try {
      devices = await FlutterBluetoothSerial.instance.getBondedDevices();
    } catch (e) {
      print("Error getting devices: $e");
    }
    setState(() {
      _devicesList = devices;
    });
  }

  void _requestEnableBluetooth() async {
    bool? enabled = await FlutterBluetoothSerial.instance.requestEnable();
    if (enabled == true) {
      _getPairedDevices();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40, bottom: 10),
            child: Row(
              children: [
                Spacer(),
                Icon(
                  Icons.add,
                  size: 30,
                )
              ],
            ),
          ),
          const Text(
            "Devices",
            style: TextStyle(fontSize: 45, fontWeight: FontWeight.w400),
          ),
          const SizedBox(
            height: 20,
          ),
          Card(
            color: Colors.white,
            child: ListTile(
              title: const Text(
                "My devices",
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20),
              ),
              subtitle:
                  const Text("Add devices to be \ncontrolled by the app."),
              trailing: TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      WidgetStateProperty.all<Color>(const Color(0xFF39B579)),
                ),
                onPressed: () {
                  if (_bluetoothState == BluetoothState.STATE_OFF) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return Alertmassege(
                          titeltext: "Turn on",
                          contenttext:
                              "To connect devices, you need to turn on your phone’s Bluetooth.",
                          button1: "Cancel",
                          button2: "Turn on",
                          onConfirm: () {
                            Navigator.of(context).pop();
                            _requestEnableBluetooth();
                          },
                        );
                      },
                    );
                  } else {
                    // بلوتوث مفتوح، ممكن تضيف وظائف أخرى هنا
                    _getPairedDevices();
                  }
                },
                child: const Text(
                  "Add device",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _devicesList.length,
              itemBuilder: (context, index) {
                BluetoothDevice device = _devicesList[index];
                return ListTile(
                  leading: const Icon(Icons.devices),
                  title: Text(device.name ?? "Unknown device"),
                  subtitle: Text(device.address),
                  onTap: () {
                    // هنا ممكن تضيف كود الاتصال بالجهاز
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
