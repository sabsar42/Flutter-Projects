import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'match_details_screen.dart';

class MatchListScreen extends StatelessWidget {
  const MatchListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Match List'),
      ),
      body: const MatchList(),
    );
  }
}
class MatchList extends StatelessWidget {
  const MatchList({super.key});


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('match_list').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        var matches = snapshot.data?.docs;

        return ListView.builder(
          itemCount: matches?.length,
          itemBuilder: (context, index) {
            var match = matches?[index].data() as Map<String, dynamic>;
            return ListTile(
              title: Text(match['match_name']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        MatchDetailsScreen(matchId: matches![index].id),
                  ),
                );
              },
              trailing: const Icon(Icons.arrow_forward),
            );
          },
        );
      },
    );
  }
}
