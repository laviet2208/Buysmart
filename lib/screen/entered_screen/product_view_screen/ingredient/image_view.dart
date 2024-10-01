import 'package:flutter/material.dart';

class image_view extends StatefulWidget {
  final List<String> imageUrls;
  const image_view({super.key, required this.imageUrls});

  @override
  State<image_view> createState() => _image_viewState();
}

class _image_viewState extends State<image_view> {
  int current = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      decoration: BoxDecoration(
        color: Colors.transparent,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: width - 30,
                alignment: Alignment.center,
                decoration: widget.imageUrls.isNotEmpty ? BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 3),
                    ),
                  ],
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: NetworkImage(widget.imageUrls[current]),
                  ),
                ) : null,

                child: widget.imageUrls.isEmpty ? Icon(Icons.image_outlined, size: 20,) : null,
              ),

              SizedBox(height: 10,),

              Container(
                height: 80,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: widget.imageUrls.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: current == index ? Border.all(
                              width: 1.5,
                              color: Colors.black,
                            ) : null,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2), // màu của shadow
                                spreadRadius: 5, // bán kính của shadow
                                blurRadius: 7, // độ mờ của shadow
                                offset: Offset(0, 2), // vị trí của shadow
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  image: DecorationImage(
                                    fit: BoxFit.fitHeight,
                                    image: NetworkImage(widget.imageUrls[index]),
                                  ),
                                ),
                                // child: Image.network(widget.imageUrls[index], fit: BoxFit.fill,),
                              ),
                            ),
                          )
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          current = index;
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
