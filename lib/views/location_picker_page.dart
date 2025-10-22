// Màn hình chọn vị trí trên bản đồ với tìm kiếm Nominatim
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../services/location_service.dart';

class LocationPickerPage extends StatefulWidget {
  final double? initialLatitude;
  final double? initialLongitude;

  const LocationPickerPage({
    Key? key,
    this.initialLatitude,
    this.initialLongitude,
  }) : super(key: key);

  @override
  State<LocationPickerPage> createState() => _LocationPickerPageState();
}

class _LocationPickerPageState extends State<LocationPickerPage> {
  final LocationService _locationService = LocationService();
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();

  late LatLng _selectedPosition;
  bool _isLoading = false;
  bool _isSearching = false;
  List<Map<String, dynamic>> _searchResults = [];
  String _selectedAddress = '';

  @override
  void initState() {
    super.initState();
    // Nếu có tọa độ ban đầu thì dùng, không thì dùng vị trí mặc định Hà Nội
    _selectedPosition = LatLng(
      widget.initialLatitude ?? 21.0285,
      widget.initialLongitude ?? 105.8542,
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  // Tìm kiếm địa điểm bằng Nominatim API
  Future<void> _searchPlace(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isSearching = true;
      _searchResults = [];
    });

    try {
      // Sử dụng Nominatim API với tiếng Việt
      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/search?'
        'q=$query&'
        'format=json&'
        'addressdetails=1&'
        'accept-language=vi&'
        'limit=5',
      );

      final response = await http.get(
        url,
        headers: {'User-Agent': 'FlutterStudentManagement/1.0'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> results = json.decode(response.body);

        setState(() {
          _searchResults = results.map((result) {
            return {
              'display_name': result['display_name'] ?? 'Không có tên',
              'lat': double.tryParse(result['lat']?.toString() ?? '0') ?? 0,
              'lon': double.tryParse(result['lon']?.toString() ?? '0') ?? 0,
            };
          }).toList();
        });

        if (_searchResults.isEmpty && mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Không tìm thấy địa điểm phù hợp'),
              backgroundColor: Colors.orange,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi tìm kiếm: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isSearching = false);
    }
  }

  // Chọn kết quả tìm kiếm
  void _selectSearchResult(Map<String, dynamic> result) {
    final lat = result['lat'] as double;
    final lon = result['lon'] as double;

    setState(() {
      _selectedPosition = LatLng(lat, lon);
      _selectedAddress = result['display_name'] as String;
      _searchResults = [];
      _searchController.clear();
    });

    _mapController.move(_selectedPosition, 15.0);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đã chọn vị trí từ kết quả tìm kiếm'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoading = true);

    try {
      final position = await _locationService.getCurrentLocation();
      if (position != null) {
        setState(() {
          _selectedPosition = LatLng(position.latitude, position.longitude);
        });
        _mapController.move(_selectedPosition, 15.0);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Đã lấy vị trí hiện tại'),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lỗi: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onMapTap(TapPosition tapPosition, LatLng position) {
    setState(() {
      _selectedPosition = position;
      _selectedAddress = ''; // Clear address khi chọn vị trí thủ công
    });
  }

  void _confirmLocation() {
    Navigator.of(context).pop({
      'latitude': _selectedPosition.latitude,
      'longitude': _selectedPosition.longitude,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chọn vị trí trên bản đồ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _confirmLocation,
            tooltip: 'Xác nhận vị trí',
          ),
        ],
      ),
      body: Stack(
        children: [
          // Bản đồ
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: _selectedPosition,
              initialZoom: 15.0,
              onTap: _onMapTap,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.prm392_student_management',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: _selectedPosition,
                    width: 80,
                    height: 80,
                    child: const Icon(
                      Icons.location_on,
                      color: Colors.red,
                      size: 50,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Ô tìm kiếm địa điểm
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // TextField tìm kiếm
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.blue),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Tìm địa điểm bằng tiếng Việt...',
                              border: InputBorder.none,
                            ),
                            onSubmitted: _searchPlace,
                          ),
                        ),
                        if (_isSearching)
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        else
                          IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () =>
                                _searchPlace(_searchController.text),
                            tooltip: 'Tìm kiếm',
                          ),
                      ],
                    ),
                  ),
                ),

                // Kết quả tìm kiếm
                if (_searchResults.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    constraints: const BoxConstraints(maxHeight: 250),
                    child: Card(
                      elevation: 4,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final result = _searchResults[index];
                          return ListTile(
                            dense: true,
                            leading: const Icon(Icons.location_on, size: 20),
                            title: Text(
                              result['display_name'] as String,
                              style: const TextStyle(fontSize: 13),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            onTap: () => _selectSearchResult(result),
                          );
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Thông tin địa chỉ đã chọn (nếu có từ tìm kiếm)
          if (_selectedAddress.isNotEmpty)
            Positioned(
              top: _searchResults.isEmpty ? 90 : 280,
              left: 16,
              right: 16,
              child: Card(
                color: Colors.green.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.green),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _selectedAddress,
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, size: 18),
                        onPressed: () {
                          setState(() => _selectedAddress = '');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),

          // Thông tin tọa độ
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Vị trí đã chọn:',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Lat: ${_selectedPosition.latitude.toStringAsFixed(6)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      'Lng: ${_selectedPosition.longitude.toStringAsFixed(6)}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Nút lấy vị trí hiện tại
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: _isLoading ? null : _getCurrentLocation,
              tooltip: 'Lấy vị trí hiện tại',
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Icon(Icons.my_location),
            ),
          ),
        ],
      ),
    );
  }
}
