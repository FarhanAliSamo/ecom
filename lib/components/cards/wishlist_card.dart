import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:ecom/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

class WishlistCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const WishlistCard({
    super.key,
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
  });

  bool get _isSvg => item.product.imageUrl.toLowerCase().endsWith('.svg');

  Widget _buildImage() {
    if (_isSvg) {
      return SvgPicture.network(
        item.product.imageUrl,
        placeholderBuilder: (context) => const Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        )),
        height: 60,
        width: 60,
        fit: BoxFit.contain,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: item.product.imageUrl,
        placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(
          color: AppColors.primary,
        )),
        errorWidget: (context, url, error) =>
            const Icon(Icons.broken_image, size: 50),
        height: 60,
        width: 60,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final formatter = NumberFormat.simpleCurrency(decimalDigits: 2);

    return Container(
      margin: const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkScaffold : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          _buildImage(),
          const SizedBox(width: 8),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.product.title,
                  style: TextStyle(
                    fontFamily: AppConstants.fontPoppins,
                    fontSize: AppConstants.medium,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.darkHeadingText
                        : AppColors.headingText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    formatter.format(
                      item.product.price * item.quantity,
                    ),
                    style: TextStyle(
                      fontFamily: AppConstants.fontPoppins,
                      fontSize: AppConstants.small,
                      color: isDark
                          ? AppColors.darkDescriptionText
                          : AppColors.descriptionText,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 0,
            child: Row(
              children: [
                _CircleIconButton(
                  icon: Icons.remove,
                  color: Colors.red,
                  onPressed: onDecrement,
                ),
                SizedBox(width: 10),
                Text(
                  item.quantity.toString(),
                  style: TextStyle(
                    fontSize: AppConstants.medium,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 10),
                _CircleIconButton(
                  icon: Icons.add,
                  color: AppColors.primary,
                  onPressed: onIncrement,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onPressed;

  const _CircleIconButton({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: color,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(4),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 16,
          ),
        ),
      ),
    );
  }
}
