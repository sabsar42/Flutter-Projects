import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MatchDetailsScreen extends StatelessWidget {
  final String matchId;

  MatchDetailsScreen({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('match_list')
              .doc(matchId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            var match = snapshot.data?.data() as Map<String, dynamic>;
            return Text('${match['match_name']}');
          },
        ),
      ),
      body: MatchDetails(matchId: matchId),
    );
  }
}

class MatchDetails extends StatelessWidget {
  final String matchId;

  MatchDetails({required this.matchId});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: FirebaseFirestore.instance
          .collection('match_list')
          .doc(matchId)
          .get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        var match = snapshot.data?.data() as Map<String, dynamic>;

        return Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    '${match['match_name']}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black38,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  '${match['score']}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Time:  ${match['time']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Total Time:  ${match['total_time']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
