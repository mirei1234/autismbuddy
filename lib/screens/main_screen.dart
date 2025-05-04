import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class MainScreen extends StatefulWidget {
  final VoidCallback onSettingsPressed;

  const MainScreen({super.key, required this.onSettingsPressed});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late List<Map<String, String>> _activities;

  late List<Map<String, String>> _emotions;

  @override
  void initState() {
    super.initState();
    _activities = List.generate(
      8,
      (index) => {
        'label': 'Activity ${index + 1}',
        'image': 'lib/assets/action${index + 1}.PNG',
      },
    );
    _emotions = List.generate(
      8,
      (index) => {
        'label': 'Emotion ${index + 1}',
        'image': 'lib/assets/emotion${index + 1}.PNG',
      },
    );
  }

  final List<Map<String, String>> _myCards = [];

  void _showCardDetails(Map<String, String> card) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  card['image']!.startsWith('http')
                      ? Image.network(
                        card['image']!,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      )
                      : Image.file(
                        File(card['image']!),
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),
                  const SizedBox(height: 12),
                  Text(
                    card['label']!,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  Future<void> _addOwnCard() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;

    final TextEditingController nameController = TextEditingController();

    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Name your card'),
            content: TextField(
              controller: nameController,
              decoration: const InputDecoration(hintText: 'Card name'),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.trim().isNotEmpty) {
                    setState(() {
                      _myCards.add({
                        'label': nameController.text.trim(),
                        'image': pickedFile.path,
                      });
                    });
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  Widget _buildCard(Map<String, String> card) {
    return GestureDetector(
      onTap: () => _showCardDetails(card),
      child: Container(
        width: 144,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            card['image']!.startsWith('http')
                ? Center(
                  child: Image.network(
                    card['image']!,
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                )
                : card['image']!.startsWith('lib/assets/')
                ? Center(
                  child: Image.asset(
                    card['image']!,
                    width: 96,
                    height: 96,
                    fit: BoxFit.contain,
                    alignment: Alignment.center,
                  ),
                )
                : Center(
                  child: Container(
                    width: 96,
                    height: 96,
                    color: Colors.grey[300],
                    child: const Center(
                      child: Text(
                        'Image\nnot\nsupported',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12, color: Colors.black54),
                      ),
                    ),
                  ),
                ),
            // Removed label text below cards as per user feedback
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF7fc9de),
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              color: const Color(0xFF3a6a78),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.home, color: Colors.white, size: 28),
                  const Text(
                    'Main screen',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Baloo 2',
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: widget.onSettingsPressed,
                  ),
                ],
              ),
            ),
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: ListView(
                      padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                      children: [
                        // Activities section
                        const Text(
                          'Activities',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo 2',
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 140,
                          child: NotificationListener<
                            OverscrollIndicatorNotification
                          >(
                            onNotification: (
                              OverscrollIndicatorNotification overscroll,
                            ) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _activities.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final activity = _activities[index];
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity != null &&
                                        details.primaryVelocity! < 0) {
                                      // Swipe left detected, do nothing but allow swipe
                                    }
                                  },
                                  child: _buildCard(activity),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // Emotions section
                        const Text(
                          'Emotions',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo 2',
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 140,
                          child: NotificationListener<
                            OverscrollIndicatorNotification
                          >(
                            onNotification: (
                              OverscrollIndicatorNotification overscroll,
                            ) {
                              overscroll.disallowIndicator();
                              return true;
                            },
                            child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _emotions.length,
                              separatorBuilder:
                                  (_, __) => const SizedBox(width: 16),
                              itemBuilder: (context, index) {
                                final emotion = _emotions[index];
                                return GestureDetector(
                                  onHorizontalDragEnd: (details) {
                                    if (details.primaryVelocity != null &&
                                        details.primaryVelocity! < 0) {
                                      // Swipe left detected, do nothing but allow swipe
                                    }
                                  },
                                  child: _buildCard(emotion),
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        // My cards section
                        const Text(
                          'My cards',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Baloo 2',
                          ),
                        ),
                        const SizedBox(height: 16),
                        GestureDetector(
                          onTap: _addOwnCard,
                          child: Container(
                            width: 72,
                            height: 72,
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(
                                  Icons.add,
                                  color: Color(0xFF3a6a78),
                                  size: 20,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Create\nmy\nown\ncard',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF3a6a78),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Baloo 2',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Display user added cards
                        SizedBox(
                          height: 140,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _myCards.length,
                            separatorBuilder:
                                (_, __) => const SizedBox(width: 16),
                            itemBuilder:
                                (context, index) => _buildCard(_myCards[index]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
