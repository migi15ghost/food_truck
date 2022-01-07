import 'dart:convert';

import 'package:food_truck/src/models/product.dart';
import 'package:food_truck/src/models/user.dart';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {

  String id;
  String idClient;
  String idAddress;
  String status;
  int timestamp;
  List<Product> products = [];
  List<Order> toList = [];
  User client;
  User delivery;

  Order({
    this.id,
    this.idClient,
    this.idAddress,
    this.status,
    this.timestamp,
    this.products,
    this.client,
    this.delivery,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
      id: json["id"] is int ? json["id"].toString() : json['id'],
      idClient: json["id_client"],
      idAddress: json["id_address"],
      status: json["status"],
      timestamp: json["timestamp"] is String ? int.parse(json["timestamp"]) : json["timestamp"],
      products: json["products"] != null ? List<Product>.from(json["products"].map((model) => model is Product ? model : Product.fromJson(model))) ?? [] : [],
      client: json['client'] is String ? userFromJson(json['client']) : json['client'] is User ? json['client'] : User.fromJson(json['client'] ?? {}),
      delivery: json['delivery'] is String ? userFromJson(json['delivery']) : json['delivery'] is User ? json['delivery'] : User.fromJson(json['delivery'] ?? {}),
  );

  Order.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((item) {
      Order order = Order.fromJson(item);
      toList.add(order);
    });
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "id_client": idClient,
    "id_address": idAddress,
    "status": status,
    "timestamp": timestamp,
    "products": products,
    "client": client,
    "delivery": delivery,
  };
}
