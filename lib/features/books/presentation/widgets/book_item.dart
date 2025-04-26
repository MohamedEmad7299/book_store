import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class BookItem extends StatefulWidget {
  final String title;
  final String author;
  final String summary;
  final String imageUrl;

  const BookItem({
    super.key,
    required this.title,
    required this.author,
    required this.summary,
    required this.imageUrl,
  });

  @override
  State<BookItem> createState() => _BookItemState();
}

class _BookItemState extends State<BookItem> with TickerProviderStateMixin {
  bool takeFullSummary = false;
  bool isConnected = false;

  @override
  void initState() {
    super.initState();
    _checkConnection();
    // Listen for connectivity changes
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> results) {
      _updateConnectionStatus(results);
    });
  }

  // Initial connection check
  Future<void> _checkConnection() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    _updateConnectionStatus(connectivityResult);
  }

  void _updateConnectionStatus(List<ConnectivityResult> results) {
    setState(() {
      isConnected = results.isNotEmpty && results[0] != ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        isConnected
            ? Image.network(
                widget.imageUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    'assets/images/default_cover.jpg',
                    width: 100,
                    height: 150,
                    fit: BoxFit.none,
                  );
                },
              )
            : Image.asset(
                'assets/images/default_cover.jpg',
                width: 100,
                height: 150,
                fit: BoxFit.cover,
              ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                widget.author,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: 20, // Minimum height to prevent collapse
                ),
                child: AnimatedSize(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  alignment: Alignment.topLeft,
                  child: Text(
                    widget.summary,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    maxLines: takeFullSummary ? null : 3,
                    overflow: takeFullSummary ? null : TextOverflow.ellipsis,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      takeFullSummary = !takeFullSummary;
                    });
                  },
                  child: Text(
                    takeFullSummary ? 'Show less' : 'Show more',
                    style: TextStyle(
                      color: Colors.indigo,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
