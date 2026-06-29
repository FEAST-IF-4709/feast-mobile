import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../core/api/api_exception.dart';
import '../../../core/router/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/providers/auth_notifier.dart';
import '../domain/table_session.dart';
import '../providers/qr_session_notifier.dart';

class ScanQrScreen extends ConsumerStatefulWidget {
  const ScanQrScreen({super.key});

  @override
  ConsumerState<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends ConsumerState<ScanQrScreen> {
  final MobileScannerController _cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
  );
  final _tokenController = TextEditingController();

  bool _isProcessing = false;
  String? _errorMessage;

  @override
  void dispose() {
    _cameraController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<TableSession?>>(qrSessionNotifierProvider, (_, next) {
      if (!mounted) return;
      next.whenOrNull(
        data: (session) {
          if (session == null) return;
          final isAuthenticated =
              ref.read(authNotifierProvider).valueOrNull
                  ?.whenOrNull(authenticated: (_, _) => true) ??
              false;
          context.go(isAuthenticated ? AppRoutes.menu : AppRoutes.login);
        },
        error: (err, _) {
          setState(() {
            _errorMessage = err is ApiException
                ? err.message
                : 'QR code tidak valid. Coba lagi.';
            _isProcessing = false;
          });
        },
      );
    });

    return Scaffold(
      backgroundColor: FeastColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // ── FEAST title ──────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 8),
              child: Center(
                child: Text(
                  'FEAST',
                  style: GoogleFonts.inter(
                    color: FeastColors.primary,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),

            // ── Camera card ──────────────────────────────────────────────────
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Camera feed (mobile only — platform view not reliable on web)
                      if (kIsWeb)
                        _WebCameraPlaceholder()
                      else
                        MobileScanner(
                          controller: _cameraController,
                          errorBuilder: (_, error, _) => _CameraError(
                            message: error.errorDetails?.message,
                          ),
                          onDetect: (capture) {
                            if (_isProcessing) return;
                            final raw = capture.barcodes
                                .where((b) => b.rawValue != null)
                                .map((b) => b.rawValue!)
                                .firstOrNull;
                            if (raw == null) return;
                            _resolveToken(raw);
                          },
                        ),

                      // Corner bracket overlay
                      CustomPaint(
                        painter: _CornerBracketPainter(
                          color: FeastColors.primary,
                        ),
                      ),

                      // Flash + gallery controls (native only — no torch on web)
                      Positioned(
                        bottom: 24,
                        left: 0,
                        right: 0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (!kIsWeb)
                              ValueListenableBuilder(
                                valueListenable: _cameraController,
                                builder: (_, state, _) => _CameraIconButton(
                                  icon: state.torchState == TorchState.on
                                      ? Icons.flashlight_on
                                      : Icons.flashlight_off,
                                  onTap: () =>
                                      _cameraController.toggleTorch(),
                                ),
                              ),
                            if (!kIsWeb) const SizedBox(width: 20),
                            _CameraIconButton(
                              icon: Icons.image_outlined,
                              onTap: () {},
                            ),
                          ],
                        ),
                      ),

                      // Processing overlay
                      if (_isProcessing)
                        Container(
                          color: Colors.black54,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: FeastColors.primary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),

            // ── Hint text ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
              child: Text(
                'Arahkan kamera ke kode QR di meja Anda\nuntuk mulai memesan.',
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: FeastColors.textDark,
                  fontSize: 14,
                ),
              ),
            ),

            // ── Error message ─────────────────────────────────────────────────
            if (_errorMessage != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: FeastColors.error.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: FeastColors.error.withValues(alpha: 0.4),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.error_outline,
                          color: FeastColors.error, size: 18),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _errorMessage!,
                          style: GoogleFonts.inter(
                              color: FeastColors.error, fontSize: 13),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => setState(() => _errorMessage = null),
                        child: Icon(
                          Icons.close,
                          color: FeastColors.error.withValues(alpha: 0.6),
                          size: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
            ],

            // ── Action buttons ────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: _isProcessing ? null : () {},
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan Otomatis'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: FeastColors.primary,
                      disabledBackgroundColor: FeastColors.primary,
                      disabledForegroundColor: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: _isProcessing ? null : _showManualInput,
                    icon: const Icon(Icons.keyboard_outlined),
                    label: const Text('Masukkan Kode Manual'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Manual input bottom sheet ─────────────────────────────────────────────

  void _showManualInput() {
    _tokenController.clear();
    setState(() => _errorMessage = null);

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: FeastColors.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetCtx) {
        return Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            top: 16,
            bottom: MediaQuery.of(sheetCtx).viewInsets.bottom + 28,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: FeastColors.divider,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Masukkan Kode Manual',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                'Masukkan URL atau kode QR yang tertera di meja Anda.',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(color: FeastColors.textLight),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _tokenController,
                autofocus: true,
                keyboardType: TextInputType.url,
                decoration: const InputDecoration(
                  hintText: 'https://app.feast.id/t/...',
                  prefixIcon: Icon(Icons.qr_code),
                ),
                onSubmitted: (_) {
                  Navigator.pop(sheetCtx);
                  _submitManualToken();
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(sheetCtx);
                  _submitManualToken();
                },
                child: const Text('Konfirmasi'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitManualToken() {
    final value = _tokenController.text.trim();
    if (value.isNotEmpty) _resolveToken(value);
  }

  Future<void> _resolveToken(String rawValue) async {
    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });
    await ref.read(qrSessionNotifierProvider.notifier).resolveToken(rawValue);
    if (mounted && _isProcessing) setState(() => _isProcessing = false);
  }
}

// ── Web camera placeholder (MobileScanner unreliable on web) ─────────────────

class _WebCameraPlaceholder extends StatelessWidget {
  const _WebCameraPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1A1A1A),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.qr_code_scanner,
                color: FeastColors.primary.withValues(alpha: 0.8), size: 72),
            const SizedBox(height: 16),
            Text(
              'Gunakan tombol\n"Masukkan Kode Manual" di bawah',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: Colors.white60, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Corner bracket painter ────────────────────────────────────────────────────

class _CornerBracketPainter extends CustomPainter {
  final Color color;
  _CornerBracketPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const bracketSize = 36.0;
    const margin = 48.0;
    final l = margin;
    final r = size.width - margin;
    final t = size.height / 2 - 130.0;
    final b = size.height / 2 + 130.0;

    // Top-left
    canvas.drawLine(Offset(l, t + bracketSize), Offset(l, t), paint);
    canvas.drawLine(Offset(l, t), Offset(l + bracketSize, t), paint);
    // Top-right
    canvas.drawLine(Offset(r - bracketSize, t), Offset(r, t), paint);
    canvas.drawLine(Offset(r, t), Offset(r, t + bracketSize), paint);
    // Bottom-left
    canvas.drawLine(Offset(l, b - bracketSize), Offset(l, b), paint);
    canvas.drawLine(Offset(l, b), Offset(l + bracketSize, b), paint);
    // Bottom-right
    canvas.drawLine(Offset(r - bracketSize, b), Offset(r, b), paint);
    canvas.drawLine(Offset(r, b), Offset(r, b - bracketSize), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ── Camera icon button ────────────────────────────────────────────────────────

class _CameraIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _CameraIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: Colors.black38,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

// ── Camera error fallback ─────────────────────────────────────────────────────

class _CameraError extends StatelessWidget {
  final String? message;
  const _CameraError({this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.videocam_off, color: Colors.white54, size: 56),
            const SizedBox(height: 12),
            Text(
              'Kamera tidak tersedia',
              style: GoogleFonts.inter(color: Colors.white70, fontSize: 15),
            ),
            if (message != null)
              Padding(
                padding: const EdgeInsets.only(top: 4),
                child: Text(
                  message!,
                  style: GoogleFonts.inter(
                      color: Colors.white38, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
