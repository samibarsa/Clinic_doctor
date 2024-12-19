// ignore_for_file: file_names

import 'package:doctor_app/Features/AddPatient/presentation/views/add_order_view.dart';
import 'package:doctor_app/Features/Home/domain/Entites/order.dart';
import 'package:doctor_app/Features/Home/domain/Entites/patient.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_cubit.dart';
import 'package:doctor_app/Features/Home/presentation/maneger/cubit/order_cubit/order_state.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/home.dart';
import 'package:doctor_app/Features/Home/presentation/widgets/navigator_bar.dart';
import 'package:doctor_app/core/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class HomePageViewWidget extends StatefulWidget {
  const HomePageViewWidget({super.key});

  void animateNavBar(int value) {
    if (value == 0) {
      padding = EdgeInsets.only(right: 220.w);
      imagePath = ImagesPath.navbarHistory;
    } else if (value == 1) {
      padding = EdgeInsets.only(left: 220.w);
      imagePath = ImagesPath.navbarHome;
    }
  }

  @override
  State<HomePageViewWidget> createState() => _HomePageViewWidgetState();
}

var pageController = PageController(initialPage: 1);

class _HomePageViewWidgetState extends State<HomePageViewWidget> {
  TextEditingController searchController = TextEditingController();
  List<Order> filteredOrders = [];
  bool isPanorama = false;
  bool isCephalometric = false;
  bool isCBCT = false;

  @override
  void initState() {
    super.initState();
    imagePath = ImagesPath.navbarHome;
    _filterOrders();
    searchController.addListener(_filterOrders);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterOrders);
    searchController.dispose();
    super.dispose();
  }

  void _filterOrders() {
    final query = searchController.text.toLowerCase();
    final state = context.read<OrderCubit>().state;
    if (state is OrderLoaded) {
      final today = DateTime.now();
      final ordersToday = state.orders.where((order) {
        return order.date.year == today.year &&
            order.date.month == today.month &&
            order.date.day == today.day;
      }).toList();

      setState(() {
        filteredOrders = ordersToday.where((order) {
          final patient = state.patient.firstWhere(
            (patient) => patient.id == order.patientId,
            orElse: () => Patient(
              name: '',
              id: 0,
              age: 0,
            ),
          );
          final patientName = patient.name.toLowerCase();
          final orderType = order.detail.type.typeName.toLowerCase();

          bool matchesType = false;
          if (isPanorama && orderType.contains('بانوراما')) matchesType = true;
          if (isCephalometric && orderType.contains('سيفالوماتريك')) {
            matchesType = true;
          }
          if (isCBCT && orderType.contains('c.b.c.t')) matchesType = true;

          return patientName.contains(query) && matchesType;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: MediaQuery.of(context).viewInsets.bottom == 0.0,
        child: NavBar(
          pageController: pageController,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: PageView(
        onPageChanged: (value) {
          setState(() {
            animateNavBar(value);
          });
        },
        controller: pageController,
        children: const [
          AddPatientView(),
          HomePage(),
        ],
      ),
    );
  }
}
