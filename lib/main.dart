import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:live_leaderboard_flutter/models/participant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Live Leaderboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF111827),
        primaryColor: const Color(0xFF374151),
        fontFamily: 'sans-serif',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
          headlineMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: const LeaderboardPage(),
    );
  }
}

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key});

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  late List<Participant> _leaderboard;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _leaderboard = [
      Participant(id: 1, name: "Alex Ryder", score: 1550),
      Participant(id: 2, name: "Brenda Starr", score: 1520),
      Participant(id: 3, name: "Casey Jones", score: 1495),
      Participant(id: 4, name: "David Kim", score: 1480),
      Participant(id: 5, name: "Eva Green", score: 1450),
      Participant(id: 6, name: "Frank Miller", score: 1425),
      Participant(id: 7, name: "Grace Lee", score: 1400),
    ];
    _startUpdates();
  }

  void _startUpdates() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _updateAndSortScores();
    });
  }

  void _updateAndSortScores() {
    final random = Random();
    setState(() {
      for (var participant in _leaderboard) {
        final scoreChange = random.nextInt(16) - 5;
        participant.score = max(0, participant.score + scoreChange);
      }
      _leaderboard.sort((a, b) => b.score.compareTo(a.score));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 672),
              child: Column(
                children: [
                  _buildHeader(),
                  const SizedBox(height: 40),
                  _buildLeaderboardTable(),
                  const SizedBox(height: 48),
                  _buildBarChart(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: const [
        Text(
          'Live Leaderboard',
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 8),
        Text(
          'Scores update every 2 seconds',
          style: TextStyle(fontSize: 16, color: Color(0xFF9CA3AF)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildLeaderboardTable() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          _buildTableHeader(),
          ..._leaderboard.asMap().entries.map((entry) {
            final index = entry.key;
            final participant = entry.value;
            return _buildTableRow(participant, index + 1);
          }),
        ],
      ),
    );
  }

  Widget _buildTableHeader() {
    return Container(
      color: const Color(0xFF374151),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: const [
          SizedBox(
            width: 64,
            child: Text(
              'RANK',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFFD1D5DB),
                  letterSpacing: 0.5),
            ),
          ),
          Expanded(
            child: Text(
              'PARTICIPANT',
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: Color(0xFFD1D5DB),
                  letterSpacing: 0.5),
            ),
          ),
          Text(
            'SCORE',
            textAlign: TextAlign.right,
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 12,
                color: Color(0xFFD1D5DB),
                letterSpacing: 0.5),
          ),
        ],
      ),
    );
  }

  Widget _buildTableRow(Participant participant, int rank) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFF374151), width: 1),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 64,
            child: Text(
              '$rank',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Color(0xFF9CA3AF),
              ),
            ),
          ),
          Expanded(
            child: Text(
              participant.name,
              style: const TextStyle(fontSize: 16),
            ),
          ),
          Text(
            participant.score.toString(),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 16, fontFamily: 'monospace'),
          ),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    final maxScore = _leaderboard.map((p) => p.score).reduce(max).toDouble();

    Color getBarColor(int rank) {
      if (rank == 1) return const Color(0xFFFBBF24);
      if (rank == 2) return const Color(0xFF9CA3AF);
      if (rank == 3) return const Color(0xFFFB923C);
      return const Color(0xFF38BDF8);
    }

    return Column(
      children: [
        const Text(
          'Score Distribution',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF1F2937),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final availableWidth = constraints.maxWidth * 0.75 - 12;
              return Column(
                children: _leaderboard.asMap().entries.map((entry) {
                  final index = entry.key;
                  final participant = entry.value;
                  final rank = index + 1;
                  final barWidth = maxScore > 0
                      ? (participant.score / maxScore) * availableWidth
                      : 0;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.25,
                          child: Text(
                            participant.name,
                            textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xFFD1D5DB)),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Container(
                            height: 24,
                            decoration: BoxDecoration(
                              color: const Color(0xFF374151),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                AnimatedContainer(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeOut,
                                  width: barWidth.toDouble(),
                                  decoration: BoxDecoration(
                                    color: getBarColor(rank),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                Positioned.fill(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${participant.score}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                        Text(
                                          '#$rank',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xFF111827),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ),
      ],
    );
  }
}
