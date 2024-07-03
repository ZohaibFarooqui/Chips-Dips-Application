import 'dart:async';
import 'package:flutter/material.dart';
import 'product_details_screen.dart';
import 'cart.dart';
import 'custom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late PageController _pageController;
  int _currentPage = 0;
  Map<String, int> quantities = {
    'Small': 0,
    'Regular': 0,
    'Jumbo': 0,
    'Chipotle Regular': 0,
    'Chipotle Jumbo': 0,
    'Smoky Regular': 0,
    'Smoky Jumbo': 0,
    'Veggie Regular': 0,
    'Veggie Jumbo': 0,
  };

  Map<String, double> prices = {
    'Small': 110.0,
    'Regular': 130.0,
    'Jumbo': 150.0,
    'Chipotle Regular': 200.0,
    'Chipotle Jumbo': 400.0,
    'Smoky Regular': 200.0,
    'Smoky Jumbo': 400.0,
    'Veggie Regular': 200.0,
    'Veggie Jumbo': 400.0,
  };

  List<String> bannerImages = [
    'lib/assets/chipsdips.jpg',
    'lib/assets/chipsdips.jpg',
    'lib/assets/chipsdips.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < bannerImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget bannerContainer({required String imagePath}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget banner() {
    return Container(
      height: 180,
      child: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemCount: bannerImages.length,
            itemBuilder: (context, index) {
              return bannerContainer(imagePath: bannerImages[index]);
            },
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(bannerImages.length, (int index) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 8,
                  width: 8,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? Colors.black : Colors.grey,
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  void incrementQuantity(String product) {
    setState(() {
      quantities[product] = (quantities[product] ?? 0) + 1;
    });
  }

  void decrementQuantity(String product) {
    setState(() {
      if (quantities[product]! > 0) {
        quantities[product] = (quantities[product] ?? 0) - 1;
      }
    });
  }

  double getTotal() {
    double total = 0.0;
    quantities.forEach((product, quantity) {
      total += (quantity * (prices[product] ?? 0.0));
    });
    return total;
  }

  void clearQuantities() {
    setState(() {
      quantities.updateAll((key, value) => 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Chips Dips',
        centerTitle: true,
        cartPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CartPage(
                cartItems: quantities,
                prices: prices,
              ),
            ),
          );
        },
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color(0xFFF4F4F4),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              banner(),
              SizedBox(height: 20),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: quantities.keys.map((product) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetails(
                              productName: product,
                              productPrice: prices[product]!,
                            ),
                          ),
                        );
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(15),
                              ),
                              child: Image.asset(
                                'lib/assets/chipsdips.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '$product',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Rs ${prices[product]}',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[700],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () => decrementQuantity(product),
                                icon: Icon(Icons.remove),
                                color: Colors.red,
                              ),
                              Text('${quantities[product]}'),
                              IconButton(
                                onPressed: () => incrementQuantity(product),
                                icon: Icon(Icons.add),
                                color: Colors.green,
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: clearQuantities,
                style: ElevatedButton.styleFrom(
                  primary: Colors.redAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                child: Text('Clear'),
              ),
              SizedBox(height: 40),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Total Sales: Rs ${getTotal().toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
