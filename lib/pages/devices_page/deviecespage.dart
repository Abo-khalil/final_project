import 'package:flutter/material.dart';

// Model for a Wi-Fi Device
typedef Device = Map<String, String>; // {'name': ..., 'ip': ...}

class DevicesPage extends StatefulWidget {
  const DevicesPage({Key? key}) : super(key: key);

  @override
  State<DevicesPage> createState() => _DevicesPageState();
}

class _DevicesPageState extends State<DevicesPage> {
  final List<Device> _devicesList = [];
  Device? _selectedDevice;

  void _onAddDevicePressed() {
    String name = '';
    String ip = '';
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Wi-Fi Device'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Device Name'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Device IP'),
              keyboardType: TextInputType.number,
              onChanged: (value) => ip = value,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (name.isNotEmpty && ip.isNotEmpty) {
                setState(() {
                  _devicesList.add({'name': name, 'ip': ip});
                });
                Navigator.pop(context);
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Devices'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: _onAddDevicePressed)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _devicesList.isEmpty
            ? const Center(child: Text('No devices added.'))
            : ListView.builder(
                itemCount: _devicesList.length,
                itemBuilder: (context, index) {
                  final device = _devicesList[index];
                  final isSelected = _selectedDevice == device;
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: const Icon(Icons.router),
                      title: Text(device['name']!),
                      subtitle: Text(device['ip']!),
                      selected: isSelected,
                      onTap: () => setState(() => _selectedDevice = device),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
