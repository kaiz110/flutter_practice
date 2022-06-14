import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:todo/models/homescreen_model.dart';
import 'package:todo/screens/todo_home_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SafeArea(
            child: Container(
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Projects',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
              ),
              Consumer<HomescreenModel>(builder: (context, homeModel, child) {
                return CarouselSlider(
                    items: homeModel.projectList.entries.map((e) {
                      return Builder(builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => e.value['page']));
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 2.5),
                            padding: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                color: Colors.black26,
                                border: Border.all(color: Colors.black12),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.15),
                                    spreadRadius: 5,
                                    blurRadius: 5,
                                    offset: Offset(
                                        0, 6), // changes position of shadow
                                  ),
                                ],
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(e.value['image']))),
                            width: MediaQuery.of(context).size.width,
                          ),
                        );
                      });
                    }).toList(),
                    options: CarouselOptions(
                        height: 400,
                        enlargeCenterPage: true,
                        enableInfiniteScroll: false,
                        onPageChanged:
                            (int index, CarouselPageChangedReason reason) {
                          homeModel.changeCurrentIndex(index);
                        }));
              }),
              Padding(
                  padding: const EdgeInsets.all(24),
                  child: Consumer<HomescreenModel>(
                      builder: (context, homeModel, child) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => homeModel.projectList[
                                    homeModel.currentID]!['page']));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          children: [
                            Expanded(
                                child: Text(
                              homeModel
                                  .projectList[homeModel.currentID]!['name'],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w600),
                            )),
                            Container(
                              width: 50,
                              height: 80,
                              child: Icon(
                                Icons.navigate_next,
                                size: 25,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  })),
            ],
          ),
        )),
      ),
    );
  }
}
