
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:instagram_two_record/constants/common_size.dart';

class RoundedAvatar extends StatelessWidget {

  final double size;

  const RoundedAvatar({
    Key? key,this.size=avatar_size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval( //이미지를 동그랗게 만들어준다.
      child: CachedNetworkImage(imageUrl: 'https://picsum.photos/100',
        width: size,
        height: size,
      ),
    );
  }
}