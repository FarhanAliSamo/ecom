import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecom/components/buttons/app_button.dart';
import 'package:ecom/components/cards/clipper.dart';
import 'package:ecom/core/app_colors.dart';
import 'package:ecom/core/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final double price;
  final String description;
  final VoidCallback onAddToCart;
  final EdgeInsets margin;

  const ProductCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.description,
    required this.onAddToCart,
    this.margin = const EdgeInsets.symmetric(vertical: 6),
  });

  bool get _isSvg => imageUrl.toLowerCase().endsWith(".svg");

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(12),
        topRight: Radius.circular(12),
      ),
      child: ClipPath(
        clipper: BottomCurveClipper(),
        child: _isSvg
            ? SvgPicture.network(
                imageUrl,
                placeholderBuilder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primary,
                )),
                height: 100,
                width: double.infinity,
                fit: BoxFit.contain,
              )
            : CachedNetworkImage(
                imageUrl: imageUrl,
                placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                  color: AppColors.primary,
                )),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.broken_image, size: 50),
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkScaffold : AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: isDark ? AppColors.borderDark : AppColors.borderLight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildImage(),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: AppConstants.fontPoppins,
                    fontSize: AppConstants.large,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.darkHeadingText
                        : AppColors.headingText,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      'Price :',
                      style: TextStyle(
                        fontFamily: AppConstants.fontPoppins,
                        fontSize: AppConstants.medium,
                        color: isDark
                            ? AppColors.darkDescriptionText
                            : AppColors.descriptionText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      price.toString(),
                      style: TextStyle(
                        fontFamily: AppConstants.fontPoppins,
                        fontSize: AppConstants.medium,
                        color: isDark
                            ? AppColors.darkDescriptionText
                            : AppColors.descriptionText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontFamily: AppConstants.fontPoppins,
                    fontSize: AppConstants.medium,
                    color: isDark
                        ? AppColors.darkDescriptionText
                        : AppColors.descriptionText,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
              child: AppButton(
                title: 'Add to Cart',
                onPressed: onAddToCart,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
