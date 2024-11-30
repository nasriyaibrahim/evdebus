
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:login/trainscreen.dart';
import 'package:login/transport_bloc/tab_bloc.dart';
import 'package:login/transport_bloc/tab_event.dart';
import 'package:login/transport_bloc/tab_state.dart';

import 'busscreen.dart';

class Home extends StatelessWidget {
  final List<Widget> _screens = [BusScreen(), TrainScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TabBloc(),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              onTap: (index) {
                BlocProvider.of<TabBloc>(context).add(TabTapped(index: index));
              },
              tabs: [
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Image.asset('assets/images/bus.png', height: 34),
                      ),
                      Text('evde Bus', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
                Tab(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: Image.asset('assets/images/train.png', height: 24),
                      ),
                      SizedBox(height: 4),
                      Text('evde Train', style: TextStyle(fontSize: 12)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: BlocBuilder<TabBloc, TabState>(
            builder: (context, state) {
              return TabBarView(
                children: _screens,
                physics:
                    NeverScrollableScrollPhysics(),
              );
            },
          ),
        ),
      ),
    );
  }
}
