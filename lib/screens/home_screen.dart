import 'package:flutter/material.dart';
import 'package:flutter_food_delivery_ui/data/data.dart';
import 'package:flutter_food_delivery_ui/models/restaurant.dart';
import 'package:flutter_food_delivery_ui/screens/cart_screen.dart';
import 'package:flutter_food_delivery_ui/screens/restaurant.screen.dart';
import 'package:flutter_food_delivery_ui/widgets/rating_stars.dart';
import 'package:flutter_food_delivery_ui/widgets/recent_orders.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget _buildRestaurants() {
    List<Widget> restaurantsList = [];
    restaurants.forEach((Restaurant restaurant) {
      restaurantsList.add(GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => RestaurantScreen(restaurant: restaurant))),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.grey[200], width: 1.0)),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Hero(
                  tag: restaurant.imageUrl,
                  child: Image(
                    image: AssetImage(restaurant.imageUrl),
                    width: 150.0,
                    height: 150.0,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(restaurant.name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20.0),
                          overflow: TextOverflow.ellipsis),
                      RatingStars(restaurant.rating),
                      SizedBox(height: 4.0),
                      Text(restaurant.address,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                          overflow: TextOverflow.ellipsis),
                      SizedBox(height: 4.0),
                      Text("0.2 miles away",
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.0),
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ));
    });
    return Column(
      children: restaurantsList,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle),
          iconSize: 30,
          onPressed: () {},
        ),
        title: Text("Food Delivery"),
        actions: [
          TextButton(
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (_) => CartScreen())),
              child: Text(
                "Cart (${currentUser.cart.length})",
                style: TextStyle(color: Colors.white, fontSize: 19),
              ))
        ],
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor, width: 8)),
                    hintText: "Search Food and Restaurants",
                    prefixIcon: Icon(
                      Icons.search,
                      size: 30,
                    ),
                    suffixIcon: Icon(
                      Icons.clear,
                    ))),
          ),
          RecentOrders(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  "Nearby Restaurants",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24.0,
                      letterSpacing: 1.0),
                ),
              )
            ],
          ),
          _buildRestaurants()
        ],
      ),
    );
  }
}
