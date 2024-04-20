import 'package:ebooks/extracted_widget/home_view/genre_display_card.dart';
import 'package:flutter/material.dart';

class GenreListView extends StatelessWidget {
  const GenreListView({
    super.key,
    required this.media,
    required this.genresArr,
  });

  final Size media;
  final List genresArr;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Row(children: [
            Text(
              "Genres",
              style: TextStyle(
                  // color: Color(0xff212121),
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            )
          ]),
        ),
        SizedBox(
          height: media.width * 0.65,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            scrollDirection: Axis.horizontal,
            itemCount: genresArr.length,
            itemBuilder: ((context, index) {
              var bObj = genresArr[index] as Map? ?? {};

              return GenreDisplayCard(
                bObj: bObj,
                bgcolor: index % 2 == 0
                    ? const Color(0xff1C4A7E)
                    : const Color(0xffC65135),
              );
            }),
          ),
        ),
      ],
    );
  }
}
