import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class BuildCard extends StatelessWidget {
  const BuildCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 815;
    double width = MediaQuery.of(context).size.width / 375;

    return FutureBuilder(
      builder: ((BuildContext context, snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("Opps! Try again later!"),
          );
        }
        if (snapshot.hasData) {
          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: ((context, index) {
              return Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
                child: Container(
                  height: height * 100,
                  width: width * 150,
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "sadf",
                            style: TextStyle(color: kGreen),
                          ),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: SvgPicture.network(
                              "rt",
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "sd",
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: width * 10,
                          ),
                          Text('sf'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        }

        return const Center(
            child: CircularProgressIndicator(
          color: kGreen,
        ));
      }),
    );
  }
}
