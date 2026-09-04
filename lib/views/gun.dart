import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_soloud/flutter_soloud.dart';
import 'package:pistol_game/components/reload_button.dart';
import 'package:torch_light/torch_light.dart';

class Gun extends StatefulWidget {
  const new({super.key});

  @override
  State<Gun> createState() => _GunState();
}

class _GunState extends State<Gun> {
  final String gunName = "GLOCK-19";
  final String gunImage = "glock_19.png";

  final int _maxBullet = 15;
  int _currentBullet = 0;

  bool _canShoot = false;
  bool _reloading = false;

  Timer? _timer;

  final SoLoud _soLoud = SoLoud.instance;

  Future<void> _shoot() async {
    if (!mounted) return;
    if (_currentBullet == 0 && !_reloading) {
      await _reload();
      return;
    }

    if (!_canShoot || _reloading) return;

    _timer?.cancel();

    setState(() {
      _canShoot = false;
      _currentBullet--;
    });

    await Future.wait([_toggleTorch(), _playShootSound()]);

    _timer = Timer(const Duration(milliseconds: 150), () {
      setState(() {
        if (_currentBullet != 0) {
          _canShoot = true;
        }
      });
    });
  }

  Future<void> _reload() async {
    if (!mounted) return;
    if (_currentBullet == 15 || _reloading) return;

    setState(() {
      _reloading = true;
    });

    await _playReloadSound();

    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 2), () {
      setState(() {
        _currentBullet = _maxBullet;
        _reloading = false;
        _canShoot = true;
      });
    });
  }

  void _cleanup() {
    if (!_soLoud.isInitialized) {
      _soLoud.stopAll();
      _soLoud.deinit();

      _timer?.cancel();
    }
  }

  Future<void> _playShootSound() async {
    await _initializeOLoud();

    await _soLoud.playSource(asset: "assets/sound/shoot.mp3");
  }

  Future<void> _playReloadSound() async {
    await _initializeOLoud();

    await _soLoud.playSource(asset: "assets/sound/reload.mp3");
  }

  Future<void> _initializeOLoud() async {
    if (!_soLoud.isInitialized) {
      await _soLoud.init();
      _soLoud.setMaxActiveVoiceCount(5);
    }
  }

  Future<void> _toggleTorch() async {
    if (await TorchLight.isTorchAvailable()) {
      await TorchLight.enableTorch();
      await TorchLight.disableTorch();
    }
  }

  @override
  void dispose() {
    _cleanup();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/image/gun_background.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(0, 0, 0, 0.5),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  BackButton(color: Colors.white),
                  Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    gunName,
                  ),
                ],
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: _shoot,
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: _canShoot
                              ? Colors.green
                              : _reloading
                              ? Colors.yellow
                              : Colors.red,
                          width: 4.0,
                        ),
                      ),
                    ),
                    child: Image(
                      image: AssetImage("assets/image/$gunImage"),
                      height: 180,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 16.0,
              ),
              decoration: BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.5)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                    "BULLET LEFT: $_currentBullet",
                  ),
                  ReloadButton(
                    reload: () {
                      _reload();
                      AlertDialog(content: Text("Hello"));
                    },
                    disabled: _reloading || _currentBullet == 15,
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
