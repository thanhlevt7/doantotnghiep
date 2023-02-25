import 'dart:ui';

import 'package:fluter_19pmd/constant.dart';
import 'package:fluter_19pmd/models/notification_models.dart';
import 'package:fluter_19pmd/services/notification/notification_event.dart';
import 'package:fluter_19pmd/services/notification/notification_bloc.dart';
import 'package:flutter/material.dart';

class Body extends StatefulWidget {
  const Body({Key key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final notificationBloc = NotificationBloc();
  @override
  void initState() {
    notificationBloc.eventSink.add(NotificationEvent.fetchForUser);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    notificationBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder<List<Notifications>>(
              initialData: [],
              stream: notificationBloc.notificationStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: Text("Bạn không có thông báo"));
                } else {
                  return Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 5);
                      },
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        final currentTime = DateTime.now();
                        final orderDate = DateTime.parse(
                            snapshot.data[index].endDate.toString());
                        final results = orderDate.difference(currentTime);
                        return Card(
                          color: Colors.white,
                          shadowColor: Colors.teal,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: _contentCard(size, snapshot, index, results),
                        );
                      },
                    ),
                  );
                }
              }),
        ],
      ),
    );
  }

  Widget _contentCard(size, snapshot, int, results) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(
                  child: Text(
                    "Thời gian : ",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                _timeNotications(results),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  "${snapshot.data[int].image}",
                  errorBuilder: (context, url, error) => const Icon(
                    Icons.error,
                    size: 50,
                  ),
                  fit: BoxFit.scaleDown,
                  height: 80,
                  width: 80,
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 240,
                      height: 30,
                      child: Text(
                        snapshot.data[int].title,
                        maxLines: 1,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                          fontWeight: FontWeight.bold,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 240,
                      height: 80,
                      child: Text(
                        snapshot.data[int].content,
                        maxLines: 4,
                        style: const TextStyle(
                          fontSize: 16,
                          color: textColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

Widget _timeNotications(results) {
  var days = results.inDays;
  var hours = results.inHours;
  var minutes = results.inMinutes;
  if (days != 0) {
    return Text(
      "Còn $days ngày",
      style: const TextStyle(color: Colors.red, fontSize: 18),
    );
  } else if (hours != 0) {
    return Text("Còn $hours giờ",
        style: const TextStyle(color: Colors.red, fontSize: 18));
  } else {
    return Text("Còn $minutes phút",
        style: const TextStyle(color: Colors.red, fontSize: 18));
  }
}
