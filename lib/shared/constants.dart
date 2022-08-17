// ignore_for_file: constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String STH_WENT_WRONG = "Something went wrong, please try again.";

const List<String> ITEMS = <String>[
  "Chair",
  "Table",
  "Dish",
  "Bowl",
  "Balloon",
];

const List<String> STATUSES = <String>[
  "Pending",
  "Approved",
  "Ongoing",
  "Edited",
  "Edit Requested",
  "Rejected",
];

const Text decoratorText = Text("DECORATOR ADMIN",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0));

const ScrollPhysics bouncingScroll =
    BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics());

const EdgeInsetsGeometry pagePadding = EdgeInsets.all(24.0);

const Color buttonCol = Color.fromARGB(255, 55, 55, 55);
const Color buttonTextCol = Color.fromARGB(255, 255, 255, 255);
const Color formFieldCol = Color.fromARGB(255, 219, 219, 219);
