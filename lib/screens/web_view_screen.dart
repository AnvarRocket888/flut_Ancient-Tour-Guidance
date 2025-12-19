import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/app_colors.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String title;

  const WebViewScreen({
    super.key,
    required this.url,
    required this.title,
  });

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  late final WebViewController _controller;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            setState(() {
              _isLoading = true;
            });
          },
          onPageFinished: (url) {
            setState(() {
              _isLoading = false;
            });
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: AppColors.primaryBg,
      navigationBar: CupertinoNavigationBar(
        backgroundColor: AppColors.secondaryBg,
        border: Border(
          bottom: BorderSide(
            color: AppColors.goldSecondary.withValues(alpha: 0.3),
            width: 1,
          ),
        ),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Icon(CupertinoIcons.back, color: AppColors.goldPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        middle: Text(
          widget.title,
          style: TextStyle(
            color: AppColors.goldPrimary,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
        trailing: _isLoading
            ? const CupertinoActivityIndicator()
            : CupertinoButton(
                padding: EdgeInsets.zero,
                child: Icon(
                  CupertinoIcons.refresh,
                  color: AppColors.goldPrimary,
                ),
                onPressed: () {
                  _controller.reload();
                },
              ),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            WebViewWidget(controller: _controller),
            if (_isLoading)
              Container(
                color: AppColors.primaryBg,
                child: const Center(
                  child: CupertinoActivityIndicator(
                    radius: 20,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
