import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../pages/your_route/route.dart';
import 'Location Bloc/loc_bloc.dart';
import 'Location Bloc/loc_event.dart';
import 'Location Bloc/loc_state.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({Key? key}) : super(key: key);

  @override
  _SearchSectionState createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  late TextEditingController fromController;
  late TextEditingController destinationController;

  @override
  void initState() {
    super.initState();
    final state = context.read<LocationBloc>().state;
    fromController = TextEditingController(text: state.from);
    destinationController = TextEditingController(text: state.destination);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final state = context.read<LocationBloc>().state;
    fromController.text = state.from;
    destinationController.text = state.destination;
  }

  @override
  void dispose() {
    fromController.dispose();
    destinationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationBloc, LocationState>(
      listener: (context, state) {
        fromController.text = state.from;
        destinationController.text = state.destination;
      },
      child: Column(
        children: [
          SizedBox(height: 8),
          Padding(
            padding: EdgeInsets.only(right: 220, top: 10),
            child: Text('Search Bus',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          Stack(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  height: 140,
                  width: 370,
                  padding: EdgeInsets.only(top: 100),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20, left: 45),
                child: Icon(Icons.place),
              ),
              Padding(
                padding: EdgeInsets.only(top: 1, left: 100),
                child: TextField(
                  controller: fromController,
                  decoration: const InputDecoration(
                    labelText: 'From',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    context.read<LocationBloc>().add(UpdateLocations(
                          from: value,
                          destination: destinationController.text,
                        ));
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 26, left: 273),
                child: IconButton(
                  icon: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(35),border: Border.all(color: Colors.blue)),
                    child: Icon(
                      Icons.swap_vert,
                      size: 50,
                      color: Colors.blue,
                    ),
                  ),
                  onPressed: () {
                    context.read<LocationBloc>().add(SwapLocations());
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 60, left: 100, right: 112),
                child: Divider(
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 93, left: 45),
                child: Icon(Icons.flag),
              ),
              Padding(
                padding: EdgeInsets.only(top: 73, left: 100),
                child: TextField(
                  controller: destinationController,
                  decoration: const InputDecoration(
                    labelText: 'Destination',
                    border: InputBorder.none,
                  ),
                  onChanged: (value) {
                    context.read<LocationBloc>().add(UpdateLocations(
                          from: fromController.text,
                          destination: value,
                        ));
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 18),
          Container(
            height: 50,
            width: 350,
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)),
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => RouteScreen(),));
              },
              child: Text(
                'Search',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          SizedBox(height: 18),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'KLO4AE2233',
                      style: TextStyle(color: Colors.black),
                    )),  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'KLO4AE2233',
                      style: TextStyle(color: Colors.black),
                    )),  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade100,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7)),
                    ),
                    onPressed: () {},
                    child: Text(
                      'KLO4AE2233',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
