import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SettingsScreen extends StatefulWidget {
  final VoidCallback onBack;

  const SettingsScreen({super.key, required this.onBack});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _soundOn = true;
  String _notificationFrequency = '1h';
  final TextEditingController _noteController = TextEditingController();
  final List<String> _notes = [];

  final List<String> _videoUrls = [
    'https://youtu.be/pxw_ALpYHaQ?si=UxBefj7K7Tc3u8nI',
    'https://youtu.be/hCleEZZ0bVs?si=6yYsTUhI0Ll1oDB1',
    'https://youtu.be/9WORlm_WU8M?si=Fk1_bB1xQ-1CMvua',
    'https://youtu.be/5K7fSaEywfY?si=JifclMzsLsEmXafZ',
    'https://youtu.be/khs6meNOBIc?si=F-XeDbugdYW1zdXQ',
    'https://youtu.be/7oKZWh9sCXU?si=oypcq_TwISv4f5Op',
    'https://youtu.be/btRv2ulZE3A?si=LC_e9XPzhZF0-Xby',
    'https://youtu.be/P7BckXhOgVk?si=69bzhwyvXSfASJ3p',
    'https://youtu.be/AA_4T9X2COI?si=R9CyOhsqcHUWp_6W',
    'https://youtu.be/ZRWuuynv1yw?si=kQlqZlU6MzC55Djq',
  ];

  late List<YoutubePlayerController> _controllers;

  @override
  void initState() {
    super.initState();
    _controllers =
        _videoUrls.map<YoutubePlayerController>((url) {
          final videoId = YoutubePlayer.convertUrlToId(url) ?? '';
          return YoutubePlayerController(
            initialVideoId: videoId,
            flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
          );
        }).toList();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    _noteController.dispose();
    super.dispose();
  }

  void _toggleSound() {
    setState(() {
      _soundOn = !_soundOn;
    });
  }

  void _setNotificationFrequency(String freq) {
    setState(() {
      _notificationFrequency = freq;
    });
  }

  void _saveNote() {
    if (_noteController.text.trim().isNotEmpty) {
      setState(() {
        _notes.add(_noteController.text.trim());
        _noteController.clear();
      });
    }
  }

  void _deleteNoteAt(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF8cc9e1),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Container(
                color: const Color(0xFF3b5a6a),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 24,
                      ),
                      onPressed: widget.onBack,
                    ),
                    const Text(
                      'Settings for parents',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Comic Neue',
                      ),
                    ),
                    const Icon(Icons.settings, color: Colors.white, size: 24),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Sound toggle
              Row(
                children: [
                  const Icon(
                    Icons.volume_up,
                    color: Color(0xFFd9f0ff),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Sound',
                      style: TextStyle(
                        fontFamily: 'Comic Neue',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Switch(
                    value: _soundOn,
                    onChanged: (val) => _toggleSound(),
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Notification frequency
              Row(
                children: [
                  const Icon(
                    Icons.notifications,
                    color: Color(0xFFd9f0ff),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      'Notifications',
                      style: TextStyle(
                        fontFamily: 'Comic Neue',
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  DropdownButton<String>(
                    value: _notificationFrequency,
                    dropdownColor: const Color(0xFF3b5a6a),
                    items: const [
                      DropdownMenuItem(
                        value: '1h',
                        child: Text(
                          '1h',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '2h',
                        child: Text(
                          '2h',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DropdownMenuItem(
                        value: '3h',
                        child: Text(
                          '3h',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                    onChanged: (val) {
                      if (val != null) _setNotificationFrequency(val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // Notes input
              const Text(
                'Notes',
                style: TextStyle(
                  fontFamily: 'Comic Neue',
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: _noteController,
                maxLines: 4,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: const Color(0xFF7fb9d1),
                  hintText: 'Text',
                  hintStyle: const TextStyle(color: Color(0xFFc6e3f3)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Comic Neue',
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: ElevatedButton(
                  onPressed: _saveNote,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4a5e6a),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 12,
                    ),
                  ),
                  child: const Text(
                    'Save note',
                    style: TextStyle(
                      fontFamily: 'Comic Neue',
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Display saved notes
              const Text(
                'My notes',
                style: TextStyle(
                  fontFamily: 'Comic Neue',
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              ..._notes.map(
                (note) => Card(
                  color: const Color(0xFF7fb9d1),
                  margin: const EdgeInsets.symmetric(vertical: 6),
                  child: ListTile(
                    title: Text(
                      note,
                      style: const TextStyle(
                        color: Colors.white,
                        fontFamily: 'Comic Neue',
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.white),
                      onPressed: () {
                        int index = _notes.indexOf(note);
                        if (index != -1) {
                          _deleteNoteAt(index);
                        }
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Videos section
              const Text(
                'Videos',
                style: TextStyle(
                  fontFamily: 'Comic Neue',
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Column(
                children:
                    _controllers.map((controller) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: YoutubePlayer(
                          controller: controller,
                          showVideoProgressIndicator: true,
                          progressIndicatorColor: Colors.blueAccent,
                        ),
                      );
                    }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
