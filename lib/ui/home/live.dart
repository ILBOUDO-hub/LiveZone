import 'package:avatar_glow/avatar_glow.dart';
import 'package:eventpro/controllers/auth_controller.dart';
import 'package:eventpro/values/colors.dart';
import 'package:eventpro/values/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:zego_uikit_prebuilt_live_streaming/zego_uikit_prebuilt_live_streaming.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LiveCircle {
  final String username;
  final String liveID;

  LiveCircle(this.username, this.liveID);
}

class livegram extends StatelessWidget {
  final List<LiveCircle> liveCircles = [
    LiveCircle('Live 1', '1234'),
    LiveCircle('Live 2', '1234'),
    LiveCircle('Live 3', '1234'),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Liste des cercles de live
        Container(
          height: 100.0,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: liveCircles.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Action à effectuer lorsqu'un cercle est cliqué (navigation vers le live)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LivePage(
                        liveID: liveCircles[index].liveID,
                        isHost: false, // En tant que spectateur
                      ),
                    ),
                  );
                },
                child: Column(
                  children: [
                    const AvatarGlow(
                      startDelay: Duration(milliseconds: 1000),
                      glowColor: Colors.redAccent,
                      endRadius: 30.0,
                      //     glowColor: primaryColor,
                      //    endRadius: Get.width * 0.25,
                      duration: Duration(milliseconds: 2000),
                      repeat: true,
                      showTwoGlows: true,
                      repeatPauseDuration: Duration(milliseconds: 100),
                      child: CircleAvatar(
                        radius: 30.0, // Ajustez la taille du cercle
                        backgroundColor: Colors.redAccent, // Couleur du cercle
                        backgroundImage: AssetImage(
                            'assets/man.png'), // Image de profil de l'utilisateur
                      ),
                    ),
                    Text(liveCircles[index]
                        .username), // Nom ou pseudonyme de l'utilisateur
                  ],
                ),
              );
            },
          ),
        ),
        // Autres contenus de votre application
      ],
    );
  }
}

class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ZegoUIKitPrebuiltLiveStreaming(
        appID: 826588411, // appID ZEGOCLOUD
        appSign:
            "9ad4e480673a62768ff904ff7b6bbf6107c3faf2b2a6925c3b14cedd5c301901", // Mon appSign ZEGOCLOUD
        userID: 'EasyPass_01',
        userName:
            "${MyAuthController.instance.firebaseUser.value!.displayName}",
        liveID: liveID, // l'ID du live
        config: isHost
            ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
            : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
      ),
    );
  }
}


/*
class LivePage extends StatelessWidget {
  final String liveID;
  final bool isHost;

  const LivePage({Key? key, required this.liveID, this.isHost = false})
      : super(key: key);

  Future<Map<String, dynamic>> getAppInfoFromFirebase() async {
    try {
      final DocumentSnapshot liveDocument = await FirebaseFirestore.instance.collection('live').doc(liveID).get();

      if (liveDocument.exists) {
        final data = liveDocument.data() as Map<String, dynamic>;
        final appID = data['appID'];
        final appSign = data['appSign'];

        if (appID != null && appSign != null) {
          return {
            'appID': appID is int ? appID : int.parse(appID), // Assurez-vous qu'il s'agit d'un int
            'appSign': appSign is String ? appSign : appSign.toString(), // Assurez-vous qu'il s'agit d'une chaîne
          };
        }
      }
    } catch (error) {
      print('Erreur lors de la récupération des informations depuis Firebase: $error');
    }

    return {}; // Retourne un Map vide si les données ne sont pas trouvées ou s'il y a une erreur.
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getAppInfoFromFirebase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('Erreur: ${snapshot.error}'),
          );
        }

        if (!snapshot.hasData) {
          return Center(
            child: Text('Aucune donnée trouvée.'),
          );
        }

        final appID = snapshot.data!['appID'] as int;
        final appSign = snapshot.data!['appSign'] as String;

        return SafeArea(
          child: ZegoUIKitPrebuiltLiveStreaming(
            appID: appID,
            appSign: appSign,
            userID: 'EasyPass_01',
            userName: "${MyAuthController.instance.firebaseUser.value!.displayName}",
            liveID: liveID,
            config: isHost
                ? ZegoUIKitPrebuiltLiveStreamingConfig.host()
                : ZegoUIKitPrebuiltLiveStreamingConfig.audience(),
          ),
        );
      },
    );
  }
}
*/