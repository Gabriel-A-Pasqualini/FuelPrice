import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VehicleWebViewScraper extends StatefulWidget {
  final String plate;
  final Function(Map<String, dynamic>) onResult;

  const VehicleWebViewScraper({
    super.key,
    required this.plate,
    required this.onResult,
  });

  @override
  State<VehicleWebViewScraper> createState() =>
      _VehicleWebViewScraperState();
}

class _VehicleWebViewScraperState extends State<VehicleWebViewScraper> {
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..addJavaScriptChannel(
        'VehicleChannel',
        onMessageReceived: (message) {
          final Map<String, dynamic> data =
              jsonDecode(message.message);
          widget.onResult(data);
        },
      )
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) => _injectJS(),
        ),
      )
      ..loadRequest(
        Uri.parse(
          'https://placasbrasil.com/placa/${widget.plate}',
        ),
      );
  }

  void _injectJS() {
    controller.runJavaScript("""
      (function() {
        const data = {};
        document.querySelectorAll('.card-detail').forEach(el => {
          const label = el.querySelector('strong')?.innerText
            ?.replace(':','')
            ?.trim();

          let value = el.querySelector('span')?.innerText?.trim();
          if (!label) return;
          if (value?.includes('Desbloquear')) value = null;

          const key = label.toLowerCase()
            .replace(/[^\\w\\s]/g,'')
            .replace(/\\s+(.)/g, (_,c) => c.toUpperCase());

          data[key] = value;
        });

        VehicleChannel.postMessage(JSON.stringify(data));
      })();
    """);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Buscando veículo")),
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
