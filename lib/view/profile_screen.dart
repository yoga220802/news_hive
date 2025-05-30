import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_hive/utils/helper.dart';
import 'package:news_hive/view/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(241, 241, 245, 1),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Data Diri',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: cBlack,
                  ),
                ),
                Text(
                  "Profil",
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: cPrimary,
                  ),
                ),
                vsTiny,
                Container(
                  decoration: BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage(
                            'assets/images/Avatar.png',
                          ),
                        ),
                        vsMedium,
                        Row(
                          children: [
                            SizedBox(
                              height: 121,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    'Email',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    'Number',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    'Address',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            hsSmall,
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ': Theresa Webb',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    ':  theresa_web@gmail.com',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    ': 089876543210',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                  Text(
                                    ': Jl. Cangkring Raya, Maleer, Kec. Batununggal, Kota Bandung, Jawa Barat 40274',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: cBlack,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                vsLarge,
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: cBlack, width: 2.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.edit_square),
                    title: Text('Edit Profile'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: cBlack, width: 2.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.password),
                    title: Text('Edit Password'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {},
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: cBlack, width: 2.0),
                    ),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SplashScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
