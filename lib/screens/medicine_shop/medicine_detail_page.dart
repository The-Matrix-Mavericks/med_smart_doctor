import 'package:demo_app/Components/progress_widget.dart';
import 'package:demo_app/Components/rating_star.dart';
import 'package:demo_app/constants/constants.dart';
import 'package:demo_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class MedicineDetailPage extends StatefulWidget {
  final String name;
  final String about;
  final String formula;
  final String image;
  String type;
  double rating;
  double goodReviews;
  double totalScore;
  double satisfaction;
  final String constraints;

  MedicineDetailPage(
      {required this.about,
      required this.formula,
      required this.image,
      required this.rating,
      required this.goodReviews,
      required this.totalScore,
      required this.satisfaction,
      required this.type,
      required this.constraints,
      required this.name});

  @override
  State<MedicineDetailPage> createState() => _MedicineDetailPageState();
}

class _MedicineDetailPageState extends State<MedicineDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8CA2AE),
      appBar: AppBar(
        backgroundColor: Color(0xFF8CA2AE),
        title: Text(
          widget.name,
          style: const TextStyle(
              fontFamily: 'Ubuntu',
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_sharp, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(children: [
        Align(
          alignment: Alignment.topCenter,
          child: Image.asset(
            widget.image,
            height: MediaQuery.of(context).size.height * .37,
          ),
        ),
        DraggableScrollableSheet(
          maxChildSize: .8,
          initialChildSize: .6,
          minChildSize: .6,
          builder: (context, scrollController) {
            return Container(
              height: MediaQuery.of(context).size.width * .5,
              padding: EdgeInsets.only(
                  left: 19,
                  right: 19,
                  top: 16), //symmetric(horizontal: 19, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.white,
              ),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(Icons.check_circle,
                              size: 18, color: Theme.of(context).primaryColor),
                        ],
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            widget.type,
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.grey,
                            ),
                          ),
                          Spacer(),
                          RatingStar(
                            rating: widget.rating,
                          )
                        ],
                      ),
                    ),
                    Divider(
                      thickness: .3,
                      color: AppColors.grey,
                    ),
                    Row(
                      children: <Widget>[
                        ProgressWidget(
                            value: widget.goodReviews,
                            totalValue: 100,
                            activeColor: AppColors.bluePeriwinkle,
                            backgroundColor: AppColors.grey.withOpacity(.3),
                            title: "Good Review",
                            durationTime: 500),
                        ProgressWidget(
                            value: widget.totalScore,
                            totalValue: 100,
                            activeColor: AppColors.bluePeriwinkle,
                            backgroundColor: AppColors.grey.withOpacity(.3),
                            title: "Total Score",
                            durationTime: 300),
                        ProgressWidget(
                            value: widget.satisfaction,
                            totalValue: 100,
                            activeColor: AppColors.bluePeriwinkleDark,
                            backgroundColor: AppColors.grey.withOpacity(.3),
                            title: "Satisfaction",
                            durationTime: 800),
                      ],
                    ),
                    Divider(
                      thickness: .3,
                      color: Color(0xFF3A5160),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "About",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      // vp16.
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.about,
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xFF3A5160),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF3A5160).withAlpha(150)),
                          child: Icon(
                            Icons.home,
                            color: Colors.white,
                          ),
                          // .ripple((){}, borderRadius:BorderRadius.circular(10), )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('Sun Pharmaceutical Industries Ltd. India.')
                      ],
                      // .vP16
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF3A5160).withAlpha(150)),
                          child: Icon(
                            Icons.call,
                            color: Colors.white,
                          ),
                          // .ripple((){}, borderRadius:BorderRadius.circular(10), )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('+91 22 4324 4324')
                      ],
                      // .vP16
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF3A5160).withAlpha(150)),
                          child: Icon(
                            Icons.alternate_email_sharp,
                            color: Colors.white,
                          ),
                          // .ripple((){}, borderRadius:BorderRadius.circular(10), )
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('secretarial@sunpharma.com')
                      ],
                      // .vP16
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
