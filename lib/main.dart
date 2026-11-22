
import 'package:flutter/material.dart';

void main() {
  runApp(const AyAjkeApp());
}

class AyAjkeApp extends StatelessWidget {
  const AyAjkeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ay Ajke Global Limited',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.indigo,
        scaffoldBackgroundColor: const Color(0xfff6f7fb),
      ),
      home: const Build10Home(),
    );
  }
}

class Build10Home extends StatefulWidget {
  const Build10Home({super.key});

  @override
  State<Build10Home> createState() => _Build10HomeState();
}

class _Build10HomeState extends State<Build10Home> {
  int tab = 0;
  String role = 'Tenant';

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(role: role, onRoleChanged: (v) => setState(() => role = v)),
      const PropertySearchPage(),
      role == 'Owner' ? const OwnerDashboard() : const TenantDashboard(),
      const VerificationPage(),
      const MarketplacePage(),
      const MoreServicesPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ay Ajke Global'),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.account_circle),
            onSelected: (v) => setState(() => role = v),
            itemBuilder: (_) => const [
              PopupMenuItem(value: 'Tenant', child: Text('Tenant')),
              PopupMenuItem(value: 'Owner', child: Text('Owner')),
            ],
          )
        ],
      ),
      body: pages[tab],
      bottomNavigationBar: NavigationBar(
        selectedIndex: tab,
        onDestinationSelected: (i) => setState(() => tab = i),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.verified_outlined), label: 'Verify'),
          NavigationDestination(icon: Icon(Icons.storefront_outlined), label: 'Market'),
          NavigationDestination(icon: Icon(Icons.apps_outlined), label: 'More'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final String role;
  final ValueChanged<String> onRoleChanged;
  const HomePage({super.key, required this.role, required this.onRoleChanged});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Rent & Property', style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 8),
                const Text('বাসা, দোকান, অফিস ও অন্যান্য সম্পত্তি খুঁজুন বা তালিকাভুক্ত করুন।'),
                const SizedBox(height: 14),
                SegmentedButton<String>(
                  segments: const [
                    ButtonSegment(value: 'Tenant', label: Text('Tenant'), icon: Icon(Icons.person_search)),
                    ButtonSegment(value: 'Owner', label: Text('Owner'), icon: Icon(Icons.home_work)),
                  ],
                  selected: {role},
                  onSelectionChanged: (s) => onRoleChanged(s.first),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        _ActionCard(
          icon: Icons.add_home_work,
          title: role == 'Owner' ? 'নতুন Property যোগ করুন' : 'Property খুঁজুন',
          subtitle: role == 'Owner'
              ? 'ভাড়া/বিক্রয়ের সম্পত্তির তথ্য দিন'
              : 'লোকেশন, বাজেট ও Property type দিয়ে খুঁজুন',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => role == 'Owner'
                  ? const AddPropertyPage()
                  : const PropertySearchPage(),
            ),
          ),
        ),
        _ActionCard(
          icon: Icons.event_available,
          title: 'Visit / Booking',
          subtitle: 'ভিজিট রিকোয়েস্ট ও বুকিং স্ট্যাটাস',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const BookingPage()),
          ),
        ),
        _ActionCard(
          icon: Icons.verified_user,
          title: 'Verification',
          subtitle: 'Owner ও Property verification status',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const VerificationPage()),
          ),
        ),
        _ActionCard(
          icon: Icons.apps,
          title: 'আরও সেবা / ইত্যাদি',
          subtitle: 'ভবিষ্যতে নতুন সেবা একই অ্যাপের মধ্যে যোগ করা যাবে',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MoreServicesPage()),
          ),
        ),
        const SizedBox(height: 12),
        const _SecurityNote(),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  const _ActionCard({required this.icon, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: CircleAvatar(child: Icon(icon)),
          title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: onTap,
        ),
      );
}

class _SecurityNote extends StatelessWidget {
  const _SecurityNote();
  @override
  Widget build(BuildContext context) => Card(
        color: Colors.indigo.withOpacity(.07),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.lock_outline),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Security foundation: role-based access, verification workflow, secure API authorization, OTP and audit logging will be connected in the backend stage.',
                ),
              ),
            ],
          ),
        ),
      );
}

class MoreServicesPage extends StatelessWidget {
  const MoreServicesPage({super.key});

  static const services = <Map<String, dynamic>>[
    {'icon': Icons.local_shipping_outlined, 'title': 'Delivery & Courier', 'subtitle': 'পার্সেল ও ডেলিভারি সেবা'},
    {'icon': Icons.build_outlined, 'title': 'Home Services', 'subtitle': 'মেরামত, পরিষ্কার ও পেশাদার সেবা'},
    {'icon': Icons.work_outline, 'title': 'Jobs & Careers', 'subtitle': 'চাকরি ও কর্মসংস্থানের সুযোগ'},
    {'icon': Icons.account_balance_wallet_outlined, 'title': 'Payment / Financial', 'subtitle': 'ভবিষ্যৎ আর্থিক সেবার জায়গা'},
    {'icon': Icons.school_outlined, 'title': 'Education', 'subtitle': 'কোর্স, শিক্ষা ও শেখার সেবা'},
    {'icon': Icons.newspaper_outlined, 'title': 'News & Media', 'subtitle': 'খবর ও তথ্য এক জায়গায়'},
    {'icon': Icons.directions_car_outlined, 'title': 'Transport', 'subtitle': 'যাতায়াত ও পরিবহন সেবা'},
    {'icon': Icons.more_horiz, 'title': 'Coming Soon', 'subtitle': 'নতুন সেবা পরে যোগ করা যাবে'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('আরও সেবা / ইত্যাদি')),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: .92,
        ),
        itemBuilder: (context, index) {
          final item = services[index];
          return Card(
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('${item['title']} — এই মডিউলটি ভবিষ্যৎ আপডেটের জন্য রাখা হয়েছে।')),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(radius: 28, child: Icon(item['icon'] as IconData, size: 28)),
                    const SizedBox(height: 12),
                    Text(item['title'] as String, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(item['subtitle'] as String, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class AddPropertyPage extends StatefulWidget {
  const AddPropertyPage({super.key});
  @override
  State<AddPropertyPage> createState() => _AddPropertyPageState();
}

class _AddPropertyPageState extends State<AddPropertyPage> {
  final form = GlobalKey<FormState>();
  final title = TextEditingController();
  final rent = TextEditingController();
  final deposit = TextEditingController();
  final size = TextEditingController();
  String type = 'Apartment';
  String purpose = 'Rent';
  String division = 'Rangpur';
  String district = 'Panchagarh';
  String upazila = 'Debiganj';

  @override
  void dispose() {
    title.dispose();
    rent.dispose();
    deposit.dispose();
    size.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Add Property')),
        body: Form(
          key: form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(controller: title, decoration: const InputDecoration(labelText: 'Property title'), validator: _req),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: type,
                decoration: const InputDecoration(labelText: 'Property type'),
                items: ['Apartment', 'House', 'Room', 'Shop', 'Office', 'Land']
                    .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
                onChanged: (v) => setState(() => type = v!),
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: purpose,
                decoration: const InputDecoration(labelText: 'Purpose'),
                items: ['Rent', 'Sale'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
                onChanged: (v) => setState(() => purpose = v!),
              ),
              const SizedBox(height: 10),
              const Text('Location'),
              Row(children: [
                Expanded(child: _drop('Division', division, ['Rangpur', 'Dhaka', 'Rajshahi', 'Chattogram'], (v) => setState(() => division = v))),
                const SizedBox(width: 8),
                Expanded(child: _drop('District', district, ['Panchagarh', 'Dinajpur', 'Rangpur', 'Dhaka'], (v) => setState(() => district = v))),
              ]),
              _drop('Upazila / Thana', upazila, ['Debiganj', 'Tetulia', 'Boda', 'Atwari'], (v) => setState(() => upazila = v)),
              TextFormField(controller: size, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Size (sq ft)')),
              const SizedBox(height: 10),
              TextFormField(controller: rent, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: purpose == 'Rent' ? 'Monthly rent' : 'Sale price'), validator: _req),
              const SizedBox(height: 10),
              TextFormField(controller: deposit, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Deposit (optional)')),
              const SizedBox(height: 14),
              const Text('Facilities', style: TextStyle(fontWeight: FontWeight.bold)),
              Wrap(spacing: 8, children: ['Parking', 'Lift', 'Gas', 'Water', 'Security', 'Generator'].map((x) => FilterChip(label: Text(x), selected: false, onSelected: (_) {})).toList()),
              const SizedBox(height: 14),
              OutlinedButton.icon(onPressed: () => _snack(context, 'Photo picker placeholder'), icon: const Icon(Icons.photo_library), label: const Text('Add Photos')),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  if (form.currentState!.validate()) {
                    _snack(context, 'Property saved locally (demo)');
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Property'),
              ),
            ],
          ),
        ),
      );

  Widget _drop(String label, String value, List<String> items, ValueChanged<String> onChanged) =>
      DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(labelText: label),
        items: items.map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (v) => onChanged(v!),
      );

  String? _req(String? v) => v == null || v.trim().isEmpty ? 'Required' : null;
}

class PropertySearchPage extends StatefulWidget {
  const PropertySearchPage({super.key});
  @override
  State<PropertySearchPage> createState() => _PropertySearchPageState();
}

class _PropertySearchPageState extends State<PropertySearchPage> {
  String type = 'All';
  String purpose = 'Rent';
  final budget = TextEditingController();

  final properties = const [
    {'title': 'Family Apartment', 'type': 'Apartment', 'location': 'Debiganj, Panchagarh', 'price': '৳12,000', 'verified': true},
    {'title': 'Shop Space', 'type': 'Shop', 'location': 'Rangpur City', 'price': '৳18,000', 'verified': true},
    {'title': 'House', 'type': 'House', 'location': 'Dhaka', 'price': '৳25,000', 'verified': false},
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Search Property')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            DropdownButtonFormField<String>(
              value: purpose,
              decoration: const InputDecoration(labelText: 'Purpose'),
              items: ['Rent', 'Sale'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
              onChanged: (v) => setState(() => purpose = v!),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(labelText: 'Property type'),
              items: ['All', 'Apartment', 'House', 'Room', 'Shop', 'Office', 'Land']
                  .map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
              onChanged: (v) => setState(() => type = v!),
            ),
            const SizedBox(height: 8),
            TextField(controller: budget, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Maximum budget', prefixText: '৳ ')),
            const SizedBox(height: 14),
            ...properties.where((p) => type == 'All' || p['type'] == type).map((p) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.home_work)),
                    title: Row(children: [
                      Expanded(child: Text(p['title']!)),
                      if (p['verified'] == true) const Icon(Icons.verified, size: 18),
                    ]),
                    subtitle: Text('${p['type']} • ${p['location']} • ${p['price']}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyDetailsPage(property: p))),
                  ),
                )),
          ],
        ),
      );

  @override
  void dispose() {
    budget.dispose();
    super.dispose();
  }
}

class PropertyDetailsPage extends StatelessWidget {
  final Map<String, Object> property;
  const PropertyDetailsPage({super.key, required this.property});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Property Details')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(height: 190, decoration: BoxDecoration(borderRadius: BorderRadius.circular(18), color: Colors.indigo.withOpacity(.1)), child: const Icon(Icons.photo, size: 80)),
            const SizedBox(height: 14),
            Text(property['title'] as String, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('${property['type']} • ${property['location']}'),
            const SizedBox(height: 8),
            Text(property['price'] as String, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            if (property['verified'] == true)
              const ListTile(leading: Icon(Icons.verified), title: Text('Verified Property'), subtitle: Text('Verification status is a demo placeholder.')),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const BookingPage())),
              icon: const Icon(Icons.event),
              label: const Text('Request Visit / Booking'),
            ),
            OutlinedButton.icon(onPressed: () => _snack(context, 'Messaging placeholder'), icon: const Icon(Icons.chat), label: const Text('Contact Owner')),
          ],
        ),
      );
}

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Visit & Booking')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(child: ListTile(leading: Icon(Icons.pending_actions), title: Text('Pending request'), subtitle: Text('Family Apartment • Demo status'))),
            const SizedBox(height: 10),
            FilledButton(onPressed: () => _snack(context, 'Visit request submitted locally (demo)'), child: const Text('Create Visit Request')),
            const SizedBox(height: 10),
            const Text('Booking workflow will later connect to secure backend, owner approval, notifications and payment.'),
          ],
        ),
      );
}

class OwnerDashboard extends StatelessWidget {
  const OwnerDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Owner Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _stat('My Properties', '0', Icons.home_work),
          _stat('Visit Requests', '0', Icons.event),
          _stat('Verification', 'Pending', Icons.verified),
          const SizedBox(height: 12),
          FilledButton.icon(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AddPropertyPage())), icon: const Icon(Icons.add), label: const Text('Add Property')),
        ],
      );
  Widget _stat(String a, String b, IconData i) => Card(child: ListTile(leading: Icon(i), title: Text(a), trailing: Text(b, style: const TextStyle(fontWeight: FontWeight.bold))));
}

class TenantDashboard extends StatelessWidget {
  const TenantDashboard({super.key});
  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          Text('Tenant Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 12),
          Card(child: ListTile(leading: Icon(Icons.search), title: Text('Saved Searches'), trailing: Text('0'))),
          Card(child: ListTile(leading: Icon(Icons.event), title: Text('My Visits / Bookings'), trailing: Text('0'))),
          Card(child: ListTile(leading: Icon(Icons.chat), title: Text('Messages'), trailing: Text('0'))),
        ],
      );
}

class VerificationPage extends StatelessWidget {
  const VerificationPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Verification Center')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _verify('Mobile OTP', 'Verified', Icons.phone_android),
            _verify('Identity Verification', 'Pending', Icons.badge),
            _verify('Owner Verification', 'Pending', Icons.person_pin),
            _verify('Property Verification', 'Pending', Icons.home_work),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Sensitive identity documents should be submitted only through a secure backend. They must not be shown to ordinary users. This build contains UI placeholders only.'),
              ),
            ),
          ],
        ),
      );

  Widget _verify(String title, String status, IconData icon) => Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(status),
          trailing: status == 'Verified' ? const Icon(Icons.check_circle) : const Icon(Icons.schedule),
        ),
      );
}



// ================= Build 06: Backend-ready security layer =================

class ApiConfig {
  // Replace with the real HTTPS API only when a backend is deployed.
  static const String baseUrl = 'https://api.example.com/v1';
  static const Duration requestTimeout = Duration(seconds: 15);
}

class Session {
  final String accessToken;
  final String userId;
  final DateTime expiresAt;

  const Session({
    required this.accessToken,
    required this.userId,
    required this.expiresAt,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

class AuthRepository {
  Session? _session;

  bool get isSignedIn => _session != null && !_session!.isExpired;

  // Demo-only local flow. Production must call the HTTPS backend,
  // validate OTP server-side, rotate tokens, and use secure storage.
  Future<bool> requestOtp(String phone) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    return phone.trim().length >= 8;
  }

  Future<Session?> verifyOtp(String phone, String otp) async {
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (phone.trim().isEmpty || otp.trim().length != 6) return null;

    _session = Session(
      accessToken: 'DEMO_TOKEN',
      userId: 'demo-user',
      expiresAt: DateTime.now().add(const Duration(hours: 1)),
    );
    return _session;
  }

  void signOut() => _session = null;
}

final authRepository = AuthRepository();

class ApiSecurityNotes {
  static const List<String> rules = [
    'HTTPS only',
    'Server-side authorization on every protected endpoint',
    'Short-lived access tokens with refresh-token rotation',
    'OTP rate limiting and brute-force protection',
    'Audit logs for sensitive actions',
    'Least-privilege role permissions',
    'Do not store NID or sensitive documents in plain text',
    'Never ship API secrets in the Flutter app',
  ];
}

class LoginPageV6 extends StatefulWidget {
  const LoginPageV6({super.key});

  @override
  State<LoginPageV6> createState() => _LoginPageV6State();
}

class _LoginPageV6State extends State<LoginPageV6> {
  final phone = TextEditingController();
  final otp = TextEditingController();
  bool otpRequested = false;
  bool busy = false;

  @override
  void dispose() {
    phone.dispose();
    otp.dispose();
    super.dispose();
  }

  Future<void> _requestOtp() async {
    setState(() => busy = true);
    final ok = await authRepository.requestOtp(phone.text);
    if (!mounted) return;
    setState(() {
      busy = false;
      otpRequested = ok;
    });
    _snack(context, ok ? 'OTP request created (demo)' : 'Enter a valid mobile number');
  }

  Future<void> _verify() async {
    setState(() => busy = true);
    final session = await authRepository.verifyOtp(phone.text, otp.text);
    if (!mounted) return;
    setState(() => busy = false);

    if (session == null) {
      _snack(context, 'Invalid OTP');
      return;
    }
    _snack(context, 'Login successful (demo)');
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Secure Login')),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            const Icon(Icons.shield_outlined, size: 72),
            const SizedBox(height: 12),
            const Text('Ay Ajke Global',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('Login with mobile verification',
                textAlign: TextAlign.center),
            const SizedBox(height: 24),
            TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Mobile number',
                prefixIcon: Icon(Icons.phone_android),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            if (otpRequested)
              TextField(
                controller: otp,
                keyboardType: TextInputType.number,
                maxLength: 6,
                decoration: const InputDecoration(
                  labelText: '6-digit OTP',
                  prefixIcon: Icon(Icons.password),
                  border: OutlineInputBorder(),
                ),
              ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: busy ? null : (otpRequested ? _verify : _requestOtp),
              icon: Icon(otpRequested ? Icons.verified : Icons.sms_outlined),
              label: Text(otpRequested ? 'Verify OTP' : 'Send OTP'),
            ),
            const SizedBox(height: 12),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Security: OTP must be verified on the server in production. '
                  'Never trust role, identity or payment status sent by the client.',
                ),
              ),
            ),
          ],
        ),
      );
}

class SecurityCenterPageV6 extends StatelessWidget {
  const SecurityCenterPageV6({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Security Center')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.verified_user_outlined),
                title: Text('Account protection'),
                subtitle: Text('OTP, session control and role-based access'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.lock_outline),
                title: Text('Sensitive data'),
                subtitle: Text('Protected by backend access rules and encryption'),
              ),
            ),
            const Card(
              child: ListTile(
                leading: Icon(Icons.history),
                title: Text('Audit trail'),
                subtitle: Text('Sensitive actions should be logged server-side'),
              ),
            ),
            const SizedBox(height: 8),
            ...ApiSecurityNotes.rules.map(
              (rule) => ListTile(
                leading: const Icon(Icons.check_circle_outline),
                title: Text(rule),
              ),
            ),
          ],
        ),
      );
}


// ================= Build 08: API integration layer =================

class ApiResult<T> {
  final bool ok;
  final T? data;
  final String? message;
  const ApiResult({required this.ok, this.data, this.message});
}

class GlobalApiClient {
  final String baseUrl;
  const GlobalApiClient({this.baseUrl = ApiConfig.baseUrl});

  // These methods are intentionally transport-agnostic placeholders.
  // Replace their bodies with a real HTTP client once the backend URL,
  // authentication flow and certificate/network policy are deployed.
  Future<ApiResult<Map<String, dynamic>>> healthCheck() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ApiResult(
      ok: true,
      data: {'service': 'ayajke-global-api', 'build': '08', 'configured': false},
    );
  }

  Future<ApiResult<Map<String, dynamic>>> getMarketplace() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ApiResult(
      ok: true,
      data: {'source': 'demo', 'items': 4},
      message: 'Connect to /api/v1/products on the deployed backend.',
    );
  }

  Future<ApiResult<Map<String, dynamic>>> getOrders() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const ApiResult(
      ok: true,
      data: {'source': 'demo'},
      message: 'Connect to /api/v1/orders on the deployed backend.',
    );
  }
}

final globalApi = GlobalApiClient();

class BackendStatusPageV8 extends StatefulWidget {
  const BackendStatusPageV8({super.key});

  @override
  State<BackendStatusPageV8> createState() => _BackendStatusPageV8State();
}

class _BackendStatusPageV8State extends State<BackendStatusPageV8> {
  bool loading = false;
  String status = 'Not checked';

  Future<void> check() async {
    setState(() {
      loading = true;
      status = 'Checking...';
    });
    final result = await globalApi.healthCheck();
    if (!mounted) return;
    setState(() {
      loading = false;
      status = result.ok
          ? 'API layer ready — backend URL not configured'
          : (result.message ?? 'API check failed');
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Backend Status')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(
              child: ListTile(
                leading: Icon(Icons.cloud_outlined),
                title: Text('Global API'),
                subtitle: Text('Build 08 integration layer'),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: ListTile(
                leading: Icon(
                  status.startsWith('API layer ready')
                      ? Icons.check_circle_outline
                      : Icons.cloud_queue_outlined,
                ),
                title: const Text('Connection status'),
                subtitle: Text(status),
              ),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: loading ? null : check,
              icon: const Icon(Icons.sync),
              label: const Text('Check API'),
            ),
            const SizedBox(height: 18),
            const Text('Planned protected API areas',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const ListTile(
              leading: Icon(Icons.person_outline),
              title: Text('/api/v1/auth and /api/v1/users'),
            ),
            const ListTile(
              leading: Icon(Icons.home_work_outlined),
              title: Text('/api/v1/properties'),
            ),
            const ListTile(
              leading: Icon(Icons.storefront_outlined),
              title: Text('/api/v1/products'),
            ),
            const ListTile(
              leading: Icon(Icons.receipt_long_outlined),
              title: Text('/api/v1/orders'),
            ),
            const ListTile(
              leading: Icon(Icons.admin_panel_settings_outlined),
              title: Text('/api/v1/admin'),
            ),
            const SizedBox(height: 8),
            const Card(
              child: Padding(
                padding: EdgeInsets.all(14),
                child: Text(
                  'Production note: use HTTPS, server-side authorization, '
                  'token rotation, rate limits and secure storage. '
                  'Do not put server secrets in the mobile app.',
                ),
              ),
            ),
          ],
        ),
      );
}

class GlobalHomePage extends StatelessWidget {
  const GlobalHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      ('Rental', 'বাসা • রুম • অফিস • দোকান • শপস', Icons.home_work_outlined),
      ('Marketplace', 'কেনা-বেচা করুন', Icons.shopping_cart_outlined),
      ('Business & Services', 'পেশাদার সেবা', Icons.handshake_outlined),
      ('Transport', 'যাতায়াত সেবা', Icons.directions_car_outlined),
      ('Payment / Financial Services', 'দ্রুত ও নিরাপদ লেনদেন', Icons.account_balance_wallet_outlined),
      ('News & Media', 'সব খবর এক জায়গায়', Icons.newspaper_outlined),
      ('Education', 'শিক্ষা হোক সহজ', Icons.school_outlined),
      ('আরও সেবা', 'আরও সেবা আসছে...', Icons.add_circle_outline),
    ];

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              expandedHeight: 205,
              title: const Text('Ay Ajke Global', style: TextStyle(fontWeight: FontWeight.bold)),
              actions: [
                IconButton(
                  icon: const Badge(
                    label: Text('3'),
                    child: Icon(Icons.notifications_none),
                  ),
                  onPressed: () => _snack(context, 'Notifications'),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 12),
                  child: CircleAvatar(child: Icon(Icons.person)),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  margin: const EdgeInsets.only(top: 56),
                  padding: const EdgeInsets.fromLTRB(16, 38, 16, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Theme.of(context).colorScheme.primaryContainer,
                        Theme.of(context).colorScheme.surface,
                      ],
                    ),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Ay Ajke Global Limited',
                          style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                      SizedBox(height: 3),
                      Text('Together for a Better Tomorrow',
                          style: TextStyle(fontSize: 13, fontStyle: FontStyle.italic)),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 10, 16, 4),
                child: TextField(
                  readOnly: true,
                  onTap: () => _snack(context, 'Global search will open here'),
                  decoration: const InputDecoration(
                    hintText: 'আপনি কী খুঁজছেন?',
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: Icon(Icons.mic_none),
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(28)),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(14),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, i) {
                    final item = services[i];
                    return Card(
                      clipBehavior: Clip.antiAlias,
                      child: InkWell(
                        onTap: () {
                          if (item.$1 == 'Marketplace') {
                            Navigator.push(context, MaterialPageRoute(builder: (_) => const MarketplacePage()));
                          } else if (item.$1 == 'Rental') {
                            _snack(context, 'Rental & Property');
                          } else {
                            _snack(context, item.$1);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(item.$3, size: 42),
                              const SizedBox(height: 8),
                              Text(item.$1,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text(item.$2, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: services.length,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.05,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('নিরাপদ ও সহজ Rental সেবা',
                          style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold)),
                    ),
                    FilledButton(
                      onPressed: () => _snack(context, 'Rental service'),
                      child: const Text('এখনই খুলুন'),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 10, 16, 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).colorScheme.primaryContainer,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.verified_user_outlined, size: 48),
                    SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'নিরাপত্তাই আমাদের অগ্রাধিকার\\n✓ যাচাইকৃত পরিচয়\\n✓ যাচাইকৃত মোবাইল\\n✓ যাচাইকৃত প্রপার্টি',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 80),
                child: Row(
                  children: [
                    const Expanded(
                      child: Text('⭐ বিশেষ অফার ও জনপ্রিয় সেবা',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                    TextButton(onPressed: () {}, child: const Text('সব দেখুন →')),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class AccountPageV5 extends StatelessWidget {
  const AccountPageV5({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Account')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
            const SizedBox(height: 10),
            const Center(child: Text('Guest User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold))),
            const SizedBox(height: 16),
            Card(
              child: Column(
                children: [
                  ListTile(leading: const Icon(Icons.login), title: const Text('Login / Register'), onTap: () => _snack(context, 'Secure login will connect to backend')),
                  ListTile(leading: const Icon(Icons.verified_user_outlined), title: const Text('Verification'), onTap: () => _snack(context, 'Verification')),
                  ListTile(
                    leading: const Icon(Icons.security_outlined),
                    title: const Text('Security Center'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SecurityCenterPageV6())),
                  ),
                  ListTile(
                    leading: const Icon(Icons.login),
                    title: const Text('Secure Login / OTP'),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPageV6())),
                  ),
                  ListTile(leading: const Icon(Icons.history), title: const Text('Activity & Audit History'), onTap: () => _snack(context, 'Activity history')),
                ],
              ),
            ),
          ],
        ),
      );
}

class Product {
  final String id;
  final String name;
  final String category;
  final String price;
  final String seller;
  final bool verified;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.seller,
    required this.verified,
    required this.description,
  });
}

const demoProducts = [
  Product(id: 'p1', name: 'Smart LED Bulb', category: 'Electronics', price: '৳650', seller: 'Global Store', verified: true, description: 'Energy-saving smart LED bulb.'),
  Product(id: 'p2', name: 'Office Chair', category: 'Furniture', price: '৳4,800', seller: 'Home & Office', verified: true, description: 'Comfortable chair for study or office use.'),
  Product(id: 'p3', name: 'School Backpack', category: 'Fashion', price: '৳1,250', seller: 'Daily Needs', verified: false, description: 'Durable everyday backpack.'),
  Product(id: 'p4', name: 'Water Bottle', category: 'Home', price: '৳450', seller: 'Daily Needs', verified: true, description: 'Reusable water bottle.'),
];

class MarketplacePage extends StatefulWidget {
  const MarketplacePage({super.key});

  @override
  State<MarketplacePage> createState() => _MarketplacePageState();
}

class _MarketplacePageState extends State<MarketplacePage> {
  String category = 'All';
  String query = '';
  final cart = <Product>[];

  @override
  Widget build(BuildContext context) {
    final products = demoProducts.where((p) {
      final q = query.trim().toLowerCase();
      final matchesCategory = category == 'All' || p.category == category;
      final matchesQuery = q.isEmpty ||
          p.name.toLowerCase().contains(q) ||
          p.category.toLowerCase().contains(q) ||
          p.seller.toLowerCase().contains(q);
      return matchesCategory && matchesQuery;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Marketplace'),
        actions: [
          IconButton(
            tooltip: 'Cart',
            icon: Badge(
              isLabelVisible: cart.isNotEmpty,
              label: Text('${cart.length}'),
              child: const Icon(Icons.shopping_cart_outlined),
            ),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartPage(items: cart)),
            ).then((_) => setState(() {})),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          TextField(
            decoration: const InputDecoration(
              labelText: 'Search products',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
            onChanged: (v) => setState(() => query = v),
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            value: category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: const ['All', 'Electronics', 'Furniture', 'Fashion', 'Home']
                .map((x) => DropdownMenuItem(value: x, child: Text(x)))
                .toList(),
            onChanged: (v) => setState(() => category = v!),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              const Expanded(child: Text('Products', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold))),
              Text('${products.length} found'),
            ],
          ),
          const SizedBox(height: 8),
          ...products.map((p) => Card(
                child: ListTile(
                  leading: CircleAvatar(child: Icon(_categoryIcon(p.category))),
                  title: Row(
                    children: [
                      Expanded(child: Text(p.name)),
                      if (p.verified) const Icon(Icons.verified, size: 18),
                    ],
                  ),
                  subtitle: Text('${p.category} • ${p.seller}\n${p.price}'),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.add_shopping_cart),
                    onPressed: () {
                      setState(() => cart.add(p));
                      _snack(context, '${p.name} added to cart');
                    },
                  ),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailsPage(
                        product: p,
                        onAdd: () {
                          setState(() => cart.add(p));
                          _snack(context, '${p.name} added to cart');
                        },
                      ),
                    ),
                  ),
                ),
              )),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => SellerDashboard()),
            ),
            icon: const Icon(Icons.store),
            label: const Text('Seller Dashboard'),
          ),
          OutlinedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersPage()),
            ),
            icon: const Icon(Icons.receipt_long),
            label: const Text('My Orders'),
          ),
        ],
      ),
    );
  }

  IconData _categoryIcon(String value) {
    switch (value) {
      case 'Electronics':
        return Icons.devices;
      case 'Furniture':
        return Icons.chair;
      case 'Fashion':
        return Icons.checkroom;
      default:
        return Icons.shopping_bag_outlined;
    }
  }
}

class ProductDetailsPage extends StatelessWidget {
  final Product product;
  final VoidCallback onAdd;

  const ProductDetailsPage({
    super.key,
    required this.product,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Product Details')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Container(
              height: 210,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                color: Colors.indigo.withOpacity(.08),
              ),
              child: const Icon(Icons.shopping_bag_outlined, size: 80),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Text(product.name, style: Theme.of(context).textTheme.headlineSmall),
                ),
                if (product.verified) const Icon(Icons.verified),
              ],
            ),
            const SizedBox(height: 8),
            Text(product.category),
            const SizedBox(height: 8),
            Text(product.price, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 14),
            Text(product.description),
            const SizedBox(height: 10),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const CircleAvatar(child: Icon(Icons.store)),
              title: Text(product.seller),
              subtitle: Text(product.verified ? 'Verified seller' : 'Verification pending'),
            ),
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Add to Cart'),
            ),
            OutlinedButton.icon(
              onPressed: () => _snack(context, 'Checkout will connect to secure payment backend.'),
              icon: const Icon(Icons.payment),
              label: const Text('Buy Now'),
            ),
          ],
        ),
      );
}

class CartPage extends StatefulWidget {
  final List<Product> items;
  const CartPage({super.key, required this.items});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final total = widget.items.length * 1000; // demo total only
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: widget.items.isEmpty
          ? const Center(child: Text('Your cart is empty'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                ...widget.items.asMap().entries.map((e) => Card(
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: Text(e.value.name),
                        subtitle: Text(e.value.price),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => setState(() => widget.items.removeAt(e.key)),
                        ),
                      ),
                    )),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    title: const Text('Demo cart total'),
                    trailing: Text('৳$total', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                FilledButton.icon(
                  onPressed: () {
                    if (widget.items.isEmpty) return;
                    final orderItems = List<Product>.from(widget.items);
                    widget.items.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => CheckoutPage(items: orderItems)),
                    );
                  },
                  icon: const Icon(Icons.shopping_cart_checkout),
                  label: const Text('Proceed to Checkout'),
                ),
              ],
            ),
    );
  }
}

class CheckoutPage extends StatelessWidget {
  final List<Product> items;
  const CheckoutPage({super.key, required this.items});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Checkout')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Card(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Text('Delivery address and payment integration will be connected to the secure backend.'),
              ),
            ),
            const SizedBox(height: 10),
            ...items.map((p) => ListTile(title: Text(p.name), trailing: Text(p.price))),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                _snack(context, 'Demo order created. Backend order ID will be generated in production.');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const OrdersPage()));
              },
              child: const Text('Place Demo Order'),
            ),
          ],
        ),
      );
}

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: const [
            Card(
              child: ListTile(
                leading: Icon(Icons.local_shipping_outlined),
                title: Text('Order #DEMO-1001'),
                subtitle: Text('Smart LED Bulb • ৳650\nStatus: Processing'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.check_circle_outline),
                title: Text('Order #DEMO-0998'),
                subtitle: Text('Office Chair • ৳4,800\nStatus: Delivered'),
              ),
            ),
            SizedBox(height: 10),
            Text('Real orders, payment confirmation, delivery tracking and refunds require backend integration.'),
          ],
        ),
      );
}

class SellerDashboard extends StatelessWidget {
  SellerDashboard({super.key});

  final products = demoProducts;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Seller Dashboard')),
        body: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const Text('Seller Dashboard', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _stat('My Products', '${products.length}', Icons.inventory_2_outlined),
            _stat('Orders', '2', Icons.receipt_long),
            _stat('Pending Verification', '1', Icons.verified_outlined),
            const SizedBox(height: 12),
            FilledButton.icon(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const AddProductPage()),
              ),
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
            OutlinedButton.icon(
              onPressed: () => _snack(context, 'Product management demo screen'),
              icon: const Icon(Icons.manage_search),
              label: const Text('Manage Products'),
            ),
          ],
        ),
      );

  Widget _stat(String a, String b, IconData i) => Card(
        child: ListTile(
          leading: Icon(i),
          title: Text(a),
          trailing: Text(b, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
      );
}

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final form = GlobalKey<FormState>();
  final name = TextEditingController();
  final price = TextEditingController();
  final description = TextEditingController();
  String category = 'Electronics';

  @override
  void dispose() {
    name.dispose();
    price.dispose();
    description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Add Product')),
        body: Form(
          key: form,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: name,
                decoration: const InputDecoration(labelText: 'Product name'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: category,
                decoration: const InputDecoration(labelText: 'Category'),
                items: const ['Electronics', 'Furniture', 'Fashion', 'Home']
                    .map((x) => DropdownMenuItem(value: x, child: Text(x)))
                    .toList(),
                onChanged: (v) => setState(() => category = v!),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: price,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Price', prefixText: '৳ '),
                validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: description,
                maxLines: 4,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                onPressed: () => _snack(context, 'Product image picker placeholder'),
                icon: const Icon(Icons.photo_library_outlined),
                label: const Text('Add Product Photos'),
              ),
              const SizedBox(height: 12),
              FilledButton.icon(
                onPressed: () {
                  if (form.currentState!.validate()) {
                    _snack(context, 'Product saved locally (demo)');
                    Navigator.pop(context);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('Save Product'),
              ),
            ],
          ),
        ),
      );
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}
