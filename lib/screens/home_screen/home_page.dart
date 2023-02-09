import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive_animation/model/course.dart';

import 'components/courses_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Courses',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w600),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses
                        .map((e) => Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CoursesCard(
                                course: e,
                              ),
                            ))
                        .toList(),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Recent',
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.w600),
                ),
              ),
              ...recentCourses.map((e) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CourseRecent(courseRecent: e),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class CourseRecent extends StatelessWidget {
  const CourseRecent({
    Key? key,
    required this.courseRecent,
  }) : super(key: key);
  final Course courseRecent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
          color: Color(0xff7553f6),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(children: [
        Expanded(
            child: Column(
          children: [
            Text(
              courseRecent.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Watch video - 15 mins',
              style: TextStyle(fontSize: 16, color: Colors.white60),
            )
          ],
        )),
        const SizedBox(
          height: 40,
          child: VerticalDivider(color: Colors.white70),
        ),
        const SizedBox(
          width: 8,
        ),
        SvgPicture.asset(courseRecent.iconSrc)
      ]),
    );
  }
}
