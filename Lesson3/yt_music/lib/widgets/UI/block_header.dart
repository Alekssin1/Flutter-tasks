import 'package:flutter/material.dart';

class BlockHeader extends StatefulWidget {
  final String title;
  final String beforeTitle;
  final String buttonTitle;

  const BlockHeader({Key? key, required this.title, this.beforeTitle = '', required this.buttonTitle}) : super(key: key);

  @override
  _BlockHeaderState createState() => _BlockHeaderState();
}

class _BlockHeaderState extends State<BlockHeader> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.beforeTitle.isNotEmpty)
              Text(
                widget.beforeTitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
              ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                _buildButton(widget.buttonTitle),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          isPressed = !isPressed;
        });
      },
      style: ButtonStyle(
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
          const EdgeInsets.fromLTRB(8.0, 2.0, 8.0, 2.0),
        ),
        backgroundColor: MaterialStateProperty.all<Color>(
          isPressed ? Colors.white : Colors.transparent,
        ),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.white.withOpacity(0.2),
              width: 1.0,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isPressed ? Colors.black : Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
