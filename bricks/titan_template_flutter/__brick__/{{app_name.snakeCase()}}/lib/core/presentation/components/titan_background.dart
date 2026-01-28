import 'dart:math';
import 'package:flutter/material.dart';

import '../../utils/assets_enum.dart';
import 'titan_asset.dart';

class TitanBackground extends StatelessWidget {
  final int diagonalCount;
  final int itemsPerDiagonal;
  final bool isLeftToRight;

  const TitanBackground({
    super.key,
    this.diagonalCount = 5,
    this.itemsPerDiagonal = 4,
    this.isLeftToRight = true,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width;
    final height = screenSize.height;

    List<Widget> children = [];

    const double logoSize = 200.0;
    

    double minOffset = -width;
    double maxOffset = height;
    double totalSpan = maxOffset - minOffset;
    double gap = totalSpan / (diagonalCount + 1);

    double columnWidth = width / itemsPerDiagonal;

  
    int startCol = -2;
    int endCol = itemsPerDiagonal + 2;

    for (int i = 1; i <= diagonalCount; i++) {
      double currentLineOffset = minOffset + (gap * i);

      for (int j = startCol; j <= endCol; j++) {
        
        double xPos = j * columnWidth;
        xPos += columnWidth / 2;

        double randomDrift = Random().nextDouble() * 20 - 10;

        double yPos;
        if (isLeftToRight) {
          yPos = xPos + currentLineOffset + randomDrift;
        } else {
          yPos = (width - xPos) + currentLineOffset + randomDrift;
        }

        if (yPos > -250 && yPos < height + 250 && 
            xPos > -250 && xPos < width + 250) {
              
          children.add(
            Positioned(
              left: xPos - (logoSize),
              top: yPos - (logoSize),
              child: Transform.rotate(
                angle: isLeftToRight ? pi / 4 : -pi / 4,
                child: TitanAsset.image(
                  assetPath: AssetsEnum.logoTransparent,
                  width: logoSize,
                ),
              ),
            ),
          );
        }
      }
    }

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        clipBehavior: Clip.none,
        children: children,
      ),
    );
  }
}