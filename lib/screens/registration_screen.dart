import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  final VoidCallback onGetStarted;

  const RegistrationScreen({super.key, required this.onGetStarted});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedAge;
  int? _selectedAvatarIndex;
  String? _selectedAvatarText;

  final List<String> _ageOptions = ['3-5 years', '6-8 years', '9-12 years'];
  final List<String> _avatarAssets = [
    'lib/assets/avatar1.jpeg',
    'lib/assets/avatar2.jpeg',
    'lib/assets/avatar3.jpeg',
  ];
  final List<String> _avatarOptions = ['Avatar 1', 'Avatar 2', 'Avatar 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7fc7df),
      body: Padding(
        padding: const EdgeInsets.only(top: 56, left: 24, right: 24),
        child: Column(
          children: [
            // Logo image - square placeholder
            Container(
              width: 144,
              height: 144,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                image: const DecorationImage(
                  image: AssetImage('lib/assets/logo.png.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'AUTISM BUDDY',
              style: TextStyle(
                color: Color(0xFF1e3a8a),
                fontWeight: FontWeight.w900,
                fontSize: 20,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Welcome to Autism Buddy!',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'We are happy to help your baby communicate!',
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
            const SizedBox(height: 32),
            // Get started button
            ElevatedButton(
              onPressed: widget.onGetStarted,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2d2d2d),
                padding: const EdgeInsets.symmetric(
                  horizontal: 48,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
              child: const Text(
                'Get started',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            const SizedBox(height: 32),
            // Form fields
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF3b5a66),
                hintText: 'Name',
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAge,
              items:
                  _ageOptions
                      .map(
                        (age) => DropdownMenuItem(
                          value: age,
                          child: Text(
                            age,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAge = value;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF3b5a66),
                hintText: 'Select age',
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: const Color(0xFF3b5a66),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _selectedAvatarText,
              items:
                  _avatarOptions
                      .map(
                        (avatar) => DropdownMenuItem(
                          value: avatar,
                          child: Text(
                            avatar,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      )
                      .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAvatarText = value;
                  _selectedAvatarIndex = _avatarOptions.indexOf(value!);
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF3b5a66),
                hintText: 'Select avatar',
                hintStyle: const TextStyle(color: Colors.white),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                  borderSide: BorderSide.none,
                ),
              ),
              dropdownColor: const Color(0xFF3b5a66),
              style: const TextStyle(color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Avatar selection - three round avatars
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(_avatarAssets.length, (index) {
                bool isSelected = _selectedAvatarIndex == index;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedAvatarIndex = index;
                      _selectedAvatarText = _avatarOptions[index];
                    });
                  },
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color:
                            isSelected ? Colors.blueAccent : Colors.transparent,
                        width: 3,
                      ),
                      image: DecorationImage(
                        image: AssetImage(_avatarAssets[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
