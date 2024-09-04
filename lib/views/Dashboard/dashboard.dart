import 'package:google_nav_bar/google_nav_bar.dart';
import '/exports/exports.dart';

import 'Home.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  void initState() {
    super.initState();
  }

  final List<IconData> icons = [
    Icons.file_copy_sharp,
    Icons.home,
    Icons.person_4,
  ];
  final labels = [
    "Complaint",
    "Home",
    "Profile",
  ];
  int _page = 1;
  // pages
  List<Widget> pages = [const Complaint(), const Home(), const ProfileScreen()];

  final _pageController = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: pages,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15),
          child: GNav(
              selectedIndex: _page,
              onTabChange: (int index) {
                setState(() {
                  _page = index;
                });
                _pageController.animateToPage(index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInSine);
              },
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Theme.of(context).primaryColor.withAlpha(500),
              iconSize: 28,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 13),
              duration: const Duration(milliseconds: 100),
              // tabBackgroundColor: Colors.grey[100]!,
              color: Colors.grey.shade400,
              tabBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.1),
              curve: Curves.easeOutExpo, // tab animation curves

              tabs: List.generate(
                3,
                (index) => GButton(
                  icon: icons[index],
                  text: labels[index],
                ),
              )),
        ),
      ),
    );
  }
}
