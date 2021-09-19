import 'package:flutter/material.dart';
import './article.dart';
import './learning_app_bar.dart';

class LearningPage extends StatelessWidget {
  const LearningPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: learningAppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            LearningCard(
              imgURL:
                  "https://thumbor.forbes.com/thumbor/960x0/https%3A%2F%2Fspecials-images.forbesimg.com%2Fimageserve%2F5f2a32ee3b52675a453e2881%2FFascinating-Examples-Of-How-Blockchain-Is-Used-In-Insurance--Banking-And-Travel%2F960x0.jpg%3Ffit%3Dscale",
              title: "What is blockchain?",
              difficulty: "Beginner",
            ),
            LearningCard(
              imgURL:
                  "http://www.deltecbank.com/wp-content/uploads/2021/08/a-golden-coin-with-ethereum-symbol-on-a-mainboard-2VUNNLP-scaled.jpg",
              title: "Blockchain Examples",
              difficulty: "Beginner",
            ),
            LearningCard(
              imgURL:
                  "https://miro.medium.com/max/1400/1*gW-yJc5paT6Snh1LFxyEgw.png",
              title: "Blockchain in Code",
              difficulty: "Intermediate",
            ),
            LearningCard(
              imgURL:
                  "https://isg-one.com/images/default-source/default-album/blockchain-use-cases.tmb-th1190-446.jpg?sfvrsn=5fa4cc31_0",
              title: "Advanced Blockchain",
              difficulty: "Advanced",
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
