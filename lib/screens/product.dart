import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:obramat/widgets/appbar.dart';
import 'package:obramat/utils/colors.dart';


class ProductScreen extends StatefulWidget {
   ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}
  
class _ProductScreenState extends State<ProductScreen> {
int _selectedImage = 0;

  final List<String> _images = [
    'lib/images/cement.png',
    'lib/images/cement2.png',
    'lib/images/cement3.png',
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    _images[_selectedImage], // 👈 imagen activa
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 70,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _images.length,
                  itemBuilder: (context, index) {
                    final isSelected = _selectedImage == index;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedImage = index),
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 70,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primaryColor
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          child: Image.asset(
                            _images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Text("PREMIUM GRADE"),
              Text('PORTLAND CEMENT CEM II 42.5 R'),
              Row(
                children: [
              RatingBarIndicator(
                rating: 4.5,
                itemCount: 5,
                itemSize: 18,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                '(128 reviews)',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'SKU: 08-9921-X',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}