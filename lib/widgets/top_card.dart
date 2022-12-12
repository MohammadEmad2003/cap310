import '../constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class TopCard extends StatelessWidget {
  const TopCard({Key? key}) : super(key: key);

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
              //print(snapshot.data![index].data!.coins![index].iconUrl);
              // var color =
              //     snapshot.data!.data!.coins![index].color?.substring(1);
              // print(color);
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
                          Text("Mohammad"),
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: SvgPicture.network(
                              "Emad",
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Hamdy",
                            style: TextStyle(),
                          ),
                          SizedBox(
                            width: width * 10,
                          ),
                          const Text(
                            '%',
                            style: TextStyle(
                                //color: Color(int.parse("0xff$color").toInt()),
                                ),
                          )
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
