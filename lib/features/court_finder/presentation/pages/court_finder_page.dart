import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/features/court_finder/presentation/widgets/court_card.dart';

class CourtFinderPage extends StatefulWidget {
  const CourtFinderPage({super.key});

  @override
  State<CourtFinderPage> createState() => _CourtFinderPageState();
}

class _CourtFinderPageState extends State<CourtFinderPage> {
  final TextEditingController _searchController = TextEditingController();
  bool isMapView = false;

  // Dummy data
  final List<Map<String, dynamic>> courts = [
    {
      'name': 'McCarren Park',
      'address': '776 Lorimer St, Brooklyn, NY',
      'distance': '0.8 mi',
      'imageUrl': 'https://images.unsplash.com/photo-1626248316688-692a832d2c12?q=80&w=2000&auto=format&fit=crop',
      'courts': 6,
    },
    {
      'name': 'Pier 2 Pickleball',
      'address': '150 Furman St, Brooklyn, NY',
      'distance': '2.1 mi',
      'imageUrl': 'https://images.unsplash.com/photo-1596555938171-872ab684c7bc?q=80&w=2000&auto=format&fit=crop',
      'courts': 4,
    },
    {
      'name': 'Central Park Courts',
      'address': 'North Meadow, New York, NY',
      'distance': '4.5 mi',
      'imageUrl': 'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop',
      'courts': 12,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: Stack(
                children: [
                  // List View
                  ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: courts.length,
                    itemBuilder: (context, index) {
                      final court = courts[index];
                      return CourtCard(
                        name: court['name'],
                        address: court['address'],
                        distance: court['distance'],
                        imageUrl: court['imageUrl'],
                        availableCourts: court['courts'],
                      );
                    },
                  ),
                  // Map Toggle Button (Floating)
                  Positioned(
                    bottom: 24,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isMapView = !isMapView;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF121212),
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isMapView ? 'List View' : 'Map View',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                isMapView ? Icons.list : Icons.map_outlined,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFEEEEEE))),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Find Courts',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF121212),
                ),
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.grey[200],
                backgroundImage: const NetworkImage(
                    'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?q=80&w=2070&auto=format&fit=crop'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xF5F5F5F5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFEEEEEE)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by location or court name',
                hintStyle: GoogleFonts.poppins(
                  color: Colors.grey[500],
                  fontSize: 14,
                ),
                border: InputBorder.none,
                icon: Icon(Icons.search, color: Colors.grey[500]),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(8),
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(Icons.tune, size: 16, color: Colors.black),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
