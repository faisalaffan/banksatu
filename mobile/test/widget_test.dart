import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:banksatu_mobile/main.dart';
import 'package:banksatu_mobile/core/di/service_locator.dart';
import 'package:banksatu_mobile/features/sme/presentation/sme_new_invoice_screen.dart';
import 'package:banksatu_mobile/features/auth/presentation/login_screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:banksatu_mobile/features/auth/presentation/session_timeout_manager.dart';

void main() {
  setUp(() {
    GetIt.instance.reset();
  });

  testWidgets('Test entire KYC flow and navigate to Dashboard', (
    WidgetTester tester,
  ) async {
    // Set a large screen size to avoid any RenderFlex overflow issues in the test environment
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    // 1. Initialize Service Locator
    setupLocator();

    // 2. Pump MyApp
    await tester.pumpWidget(const MyApp());
    await tester
        .pump(); // Use pump instead of pumpAndSettle to avoid infinite animation timeout

    // 3. We should be on the OnboardingScreen. Verify "Buka Rekening" button is present.
    expect(find.text('Buka Rekening'), findsOneWidget);

    // 4. Tap "Buka Rekening"
    await tester.tap(find.text('Buka Rekening'));
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    ); // allow page transition to complete

    // 5. We should be on KYCIdentityScreen. Verify "Ambil Foto ID" or similar text/button is present.
    expect(find.text('Open Camera to Capture'), findsOneWidget);
    await tester.tap(find.text('Open Camera to Capture'));
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    ); // allow page transition to complete

    // 6. We should be on KYCFaceScreen. Verify "Scan Face" button is present.
    expect(find.text('Scan Face'), findsOneWidget);
    await tester.tap(find.text('Scan Face'));

    // Pump periodically to let the face scan complete (takes 2.5 seconds, incrementing by 0.04 every 100ms)
    for (int i = 0; i < 30; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }

    // Wait for the navigation to KYCSuccessScreen (delayed by 800ms)
    await tester.pump(const Duration(milliseconds: 800));
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    ); // allow page transition

    // 7. We should be on KYCSuccessScreen. Verify "Mulai Menjelajah" button is present.
    expect(find.text('Mulai Menjelajah'), findsOneWidget);

    // 8. Tap "Mulai Menjelajah"
    await tester.tap(find.text('Mulai Menjelajah'));
    await tester.pump();
    await tester.pump(
      const Duration(milliseconds: 500),
    ); // allow page transition

    // 9. Verify we are on Dashboard (find 'Selamat Pagi' or similar)
    expect(find.text('Selamat Pagi,'), findsOneWidget);

    // Reset view size
    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('Test SMENewInvoiceScreen initialization and rendering', (
    WidgetTester tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: SMENewInvoiceScreen())),
    );
    await tester.pump();

    // Verify Batas Pembayaran is visible and formatted without throwing exceptions
    expect(find.text('Batas Pembayaran'), findsOneWidget);

    // Verify client name is visible
    expect(find.text('Nama Klien / Perusahaan'), findsOneWidget);

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('Test LoginScreen PIN input rendering and keypad', (WidgetTester tester) async {
    tester.view.physicalSize = const Size(1200, 1920);
    tester.view.devicePixelRatio = 1.0;

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoginScreen(),
        ),
      ),
    );
    await tester.pump();

    // Verify "Faisal Affan" is displayed
    expect(find.text('Faisal Affan'), findsOneWidget);
    expect(find.text('Selamat Datang Kembali,'), findsOneWidget);

    // Verify key 1 is displayed and can be pressed
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.text('1'));
    await tester.pump();

    tester.view.resetPhysicalSize();
    tester.view.resetDevicePixelRatio();
  });

  testWidgets('Test SessionTimeoutManager rendering', (WidgetTester tester) async {
    FlutterSecureStorage.setMockInitialValues({'bank_satu_auth_token': 'mock_token_123456'});

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SessionTimeoutManager(
            child: SizedBox(),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(find.byType(SessionTimeoutManager), findsOneWidget);
  });
}
