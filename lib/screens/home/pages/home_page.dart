import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constants.dart';
import '../../../widgets/lightBox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget profile(String name, String mail, String phone) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text("Name: ",
                style: TextStyle(fontFamily: "MYRIADPRO", color: kGreen)),
            Text(
              name,
              style:
                  const TextStyle(fontFamily: "MYRIADPRO", color: kLightGrey),
            ),
          ],
        ),
        Row(
          children: [
            const Text("E-mail: ",
                style: TextStyle(fontFamily: "MYRIADPRO", color: kGreen)),
            Text(
              mail,
              style:
                  const TextStyle(fontFamily: "MYRIADPRO", color: kLightGrey),
            ),
          ],
        ),
        Row(
          children: [
            const Text("Phone: ",
                style: TextStyle(fontFamily: "MYRIADPRO", color: kGreen)),
            Text(
              phone,
              style:
                  const TextStyle(fontFamily: "MYRIADPRO", color: kLightGrey),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: height / 2.8,
            color: kBlack,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: LayoutBuilder(builder: (BuildContext context, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Group 310',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      profile(
                          "Mohammad Emad",
                          "mohammed.1020063@stemoctober.moe.edu.eg",
                          "+201116252559"),
                      const SizedBox(height: 15),
                      profile(
                          "Kareem Tantawy",
                          "mohammed.1020063@stemoctober.moe.edu.eg",
                          "+201116252559"),
                      const SizedBox(height: 15),
                      profile(
                          "Khalid Amgad",
                          "mohammed.1020063@stemoctober.moe.edu.eg",
                          "+201116252559")
                    ],
                  ),
                ],
              );
            }),
          ),
          Container(
            color: kWhite,
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                lighBox(
                  height: height / 12,
                  width: width,
                  backgroundImage: "images/icons/box.png",
                  image: "images/icons/rocket.png",
                  heading: "Portfolio",
                  subHeading: "A4 Portfolio Group 310",
                  onTap: () async {},
                ),
                const SizedBox(
                  height: 15,
                ),
                lighBox(
                  height: height / 12,
                  width: width,
                  backgroundImage: "images/icons/box.png",
                  image: "images/icons/credit.png",
                  heading: "Poster",
                  subHeading: "A4 Poster Group 310",
                  onTap: () async {
                    const url = 'https://www.youtube.com/watch?v=T0qbFgbFhg0';
                    // ignore: deprecated_member_use
                    if (await canLaunch(url)) {
                      await launch(url,
                          forceWebView: true, enableJavaScript: true);
                    }
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
