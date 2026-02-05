import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 4,
        child: _TabsNonScrollableDemo(),
      ),
    );
  }
}

class _TabsNonScrollableDemo extends StatefulWidget {
  @override
  __TabsNonScrollableDemoState createState() => __TabsNonScrollableDemoState();
}

class __TabsNonScrollableDemoState extends State<_TabsNonScrollableDemo>
    with SingleTickerProviderStateMixin, RestorationMixin {
  late TabController _tabController;

  final RestorableInt tabIndex = RestorableInt(0);

  @override
  String get restorationId => 'tab_non_scrollable_demo';

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(tabIndex, 'tab_index');
    _tabController.index = tabIndex.value;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      initialIndex: 0,
      length: 4,
      vsync: this,
    );
    _tabController.addListener(() {
      setState(() {
        tabIndex.value = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    tabIndex.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // For the To do task hint: consider defining the widget and name of the
    // tabs here
    final tabs = ['Tab 1', 'Tab 2', 'Tab 3', 'Tab 4'];

    // Simple data for Tab 4 list
    final listItems = [
      {'title': 'Item 1', 'subtitle': 'Details for item 1'},
      {'title': 'Item 2', 'subtitle': 'Details for item 2'},
      {'title': 'Item 3', 'subtitle': 'Details for item 3'},
      {'title': 'Item 4', 'subtitle': 'Details for item 4'},
    ];

    // Different background color per tab
    final tabColors = <Color>[
      Color(0xFF1E1E1E), // Tab 1 (dark)
      Color(0xFFE3F2FD), // Tab 2 (light blue)
      Color(0xFFE8F5E9), // Tab 3 (light green)
      Color(0xFFFFF8E1), // Tab 4 (light amber)
    ];

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Tabs Demo',
          style: GoogleFonts.montserrat(),
        ),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: false,
          labelStyle: GoogleFonts.montserrat(fontWeight: FontWeight.w600),
          unselectedLabelStyle: GoogleFonts.montserrat(),
          tabs: [
            for (final tab in tabs) Tab(text: tab),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // hint for the to do task: Considering creating the different for
          // different tabs

          // TAB 1: Text widget + AlertDialog (Montserrat + #C5C0C0)
          Container(
            color: tabColors[0],
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome to ${tabs[0]}',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC5C0C0),
                        letterSpacing: 0.5,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'This is a simple text widget with customized styling.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFFC5C0C0),
                      ),
                    ),
                    SizedBox(height: 18),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: Text(
                                'Alert Dialog',
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              content: Text(
                                'Hello from ${tabs[0]}!',
                                style: GoogleFonts.montserrat(),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                  child: Text(
                                    'OK',
                                    style: GoogleFonts.montserrat(),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text(
                        'Show Alert',
                        style: GoogleFonts.montserrat(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // TAB 2: Input text widgets + Image.network
          Container(
            color: tabColors[1],
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        labelStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(),
                      ),
                      style: GoogleFonts.montserrat(),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter a short note',
                        labelStyle: GoogleFonts.montserrat(),
                        border: OutlineInputBorder(),
                      ),
                      style: GoogleFonts.montserrat(),
                      maxLines: 2,
                    ),
                    SizedBox(height: 16),
                    Image.network(
                      'https://i.imgur.com/HJ2SVRz.jpeg',
                      width: 150,
                      height: 150,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 150,
                          height: 150,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Image failed to load',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.montserrat(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          