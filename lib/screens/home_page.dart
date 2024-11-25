import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const TabBar(
                isScrollable: true,
                indicator: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.transparent,
                    ),
                  ),
                ),
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 0,
                tabs: [
                  Tab(text: 'Headlines'),
                  Tab(text: 'Sports'),
                  Tab(text: 'Technology'),
                  Tab(text: 'Health'),
                  Tab(text: 'Entertainment'),
                ],
                tabAlignment: TabAlignment.start,
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  Center(child: Text('Headlines')),
                  Center(child: Text('Sports')),
                  Center(child: Text('Technology')),
                  Center(child: Text('Health')),
                  Center(child: Text('Entertainment')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
