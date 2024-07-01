import 'package:flutter/material.dart';
import 'package:lexisnap/features/home/domain/entities/minimal_tag.dart';
import 'package:lexisnap/features/home/presentation/widgets/field_title_card.dart';
import 'package:lexisnap/features/home/presentation/widgets/tags_card.dart';

class TagsSection extends StatelessWidget {
  final List<MinimalTag> tags;
  const TagsSection({
    super.key,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const FieldTitleCard(title: 'Tags'),
            IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => const TagsDialog(),
                );
              },
              icon: const Icon(Icons.add_rounded),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: [
            for (final tag in tags)
              TagCard(
                tag: tag,
                fromDialog: false,
              ),
          ],
        ),
      ],
    );
  }
}
