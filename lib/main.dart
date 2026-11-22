import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Ay Ajke Global',
    theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
    home: const LoginPage(),
  );
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  final phone = TextEditingController();
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Ay Ajke Global')),
    body: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const SizedBox(height: 30),
        const Text('Welcome', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        const Text('Login or create your account'),
        const SizedBox(height: 24),
        TextField(controller: phone, keyboardType: TextInputType.phone,
          decoration: const InputDecoration(labelText: 'Mobile Number', prefixIcon: Icon(Icons.phone), border: OutlineInputBorder())),
        const SizedBox(height: 14),
        FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())), child: const Text('Continue')),
        TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage())), child: const Text('Create new account')),
      ]),
    ),
  );
}

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Registration')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      const TextField(decoration: InputDecoration(labelText: 'Full Name', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText: 'Mobile Number', border: OutlineInputBorder())),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        decoration: const InputDecoration(labelText: 'Account Type', border: OutlineInputBorder()),
        items: const ['User', 'Owner', 'Seller', 'Service Provider'].map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
        onChanged: (_) {},
      ),
      const SizedBox(height: 12),
      FilledButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const LocationPage())), child: const Text('Continue to Location')),
    ]),
  );
}

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});
  @override State<LocationPage> createState() => _LocationPageState();
}
class _LocationPageState extends State<LocationPage> {
  String country = 'Bangladesh', region = 'Select', district = 'Select', thana = 'Select', union = 'Select', village = 'Select';
  Widget pick(String label, String value, List<String> items, void Function(String?) onChanged) => Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: DropdownButtonFormField<String>(
      value: value == 'Select' ? null : value,
      decoration: InputDecoration(labelText: label, border: const OutlineInputBorder()),
      items: items.map((x) => DropdownMenuItem(value: x, child: Text(x))).toList(),
      onChanged: onChanged,
    ),
  );
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Select Location')),
    body: ListView(padding: const EdgeInsets.all(20), children: [
      pick('Country', country, const ['Bangladesh', 'India', 'Saudi Arabia', 'UAE', 'United Kingdom'], (v) => setState(() => country = v!)),
      pick('Division / State / Province', region, const ['Dhaka', 'Chattogram', 'Rajshahi', 'Khulna', 'Barishal', 'Sylhet', 'Rangpur', 'Mymensingh'], (v) => setState(() => region = v!)),
      pick('District', district, const ['Panchagarh', 'Dhaka', 'Chattogram', 'Rangpur'], (v) => setState(() => district = v!)),
      pick('Thana / Upazila', thana, const ['Debiganj', 'Sadar', 'Kotwali'], (v) => setState(() => thana = v!)),
      pick('Union / Municipality', union, const ['Select Union', 'Municipality'], (v) => setState(() => union = v!)),
      pick('Village / Para / Mohalla', village, const ['Select Village', 'Select Para'], (v) => setState(() => village = v!)),
      const TextField(decoration: InputDecoration(labelText: 'Road / Street', border: OutlineInputBorder())),
      const SizedBox(height: 10),
      const TextField(decoration: InputDecoration(labelText: 'House / Building No.', border: OutlineInputBorder())),
      const SizedBox(height: 16),
      FilledButton(onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())), child: const Text('Save Location')),
    ]),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const services = ['🏠 Rent & Property','🛒 Marketplace','🚚 Courier','🚗 Transport','🌾 Agriculture','🐄 Livestock','👗 Fashion','💄 Cosmetics','📰 News & Media','📚 Education','💳 Payment','➕ More'];
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Ay Ajke Global'), actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.notifications_none)), IconButton(onPressed: (){}, icon: const Icon(Icons.person_outline))]),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const TextField(decoration: InputDecoration(hintText: 'Search anything', prefixIcon: Icon(Icons.search), border: OutlineInputBorder())),
      const SizedBox(height: 20),
      const Text('Services', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      const SizedBox(height: 12),
      GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 8, mainAxisSpacing: 8),
        itemBuilder: (_, i) => Card(child: Center(child: Padding(padding: const EdgeInsets.all(6), child: Text(services[i], textAlign: TextAlign.center))))),
    ]),
    bottomNavigationBar: const NavigationBar(destinations: [
      NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
      NavigationDestination(icon: Icon(Icons.apps_outlined), label: 'Services'),
      NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
      NavigationDestination(icon: Icon(Icons.notifications_none), label: 'Alerts'),
      NavigationDestination(icon: Icon(Icons.person_outline), label: 'Account'),
    ]),
  );
}
