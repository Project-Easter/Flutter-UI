import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AboutUs extends StatelessWidget {
  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in odio condimentum, pellentesque ex at, condimentum nisi. Aliquam erat volutpat. Proin nisl tellus, egestas sed mi eu, tempus egestas diam. Proin eu suscipit nisl. Cras ac libero ipsum. Curabitur blandit tempor mauris quis laoreet. Etiam at fringilla eros.\n'
      'Maecenas a accumsan nibh. Fusce id lectus a quam placerat porttitor non non enim. Mauris vulputate sodales metus nec pellentesque. Morbi id est vel libero euismod hendrerit nec non urna. Suspendisse at ante ligula. Maecenas commodo mi in interdum lobortis. Aenean gravida luctus enim, eget tempus enim cursus et. Donec tincidunt felis quis ex pretium, a maximus leo finibus. Ut hendrerit massa ut ipsum ornare sodales. Nunc malesuada at nibh vitae malesuada. Phasellus nec justo condimentum, ullamcorper sapien vel, venenatis ligula. Nulla vel arcu ac augue imperdiet finibus sodales dapibus leo.\n'
      'Sed vitae justo et velit venenatis placerat eu vel lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac risus sit amet felis lacinia ullamcorper a quis tellus. Ut ac ipsum fermentum, efficitur nulla sed, bibendum velit. Maecenas sit amet quam diam. Etiam in facilisis orci. Duis nunc mauris, mollis quis ligula in, fringilla tristique mi. Sed eget scelerisque arcu, accumsan mollis metus. Nullam lobortis augue ex, in vestibulum turpis accumsan vitae. Nunc sit amet risus enim. Nunc ac mauris eu diam dignissim vestibulum. Donec libero nisl, sodales eget ex vel, dignissim faucibus leo. Donec quis nulla porta, lacinia purus euismod, suscipit ante. Ut nec ultricies dolor, quis ornare justo. Ut eleifend ex in turpis posuere, sit amet iaculis lacus tempus.\n'
      'Donec feugiat justo eget efficitur laoreet. Mauris eget sapien faucibus, tincidunt ex at, condimentum urna. Vivamus sodales lectus diam, vitae eleifend eros rhoncus vel. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fermentum arcu sed placerat vehicula. Cras maximus eu nibh vitae feugiat. Ut nec sem vel justo lobortis maximus sed vitae ligula. Phasellus ullamcorper lorem id sapien viverra consequat. Donec lobortis eu mi at faucibus.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text('About Us',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    ));
  }
}

class PrivacyPolicy extends StatelessWidget {
  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in odio condimentum, pellentesque ex at, condimentum nisi. Aliquam erat volutpat. Proin nisl tellus, egestas sed mi eu, tempus egestas diam. Proin eu suscipit nisl. Cras ac libero ipsum. Curabitur blandit tempor mauris quis laoreet. Etiam at fringilla eros.\n'
      'Maecenas a accumsan nibh. Fusce id lectus a quam placerat porttitor non non enim. Mauris vulputate sodales metus nec pellentesque. Morbi id est vel libero euismod hendrerit nec non urna. Suspendisse at ante ligula. Maecenas commodo mi in interdum lobortis. Aenean gravida luctus enim, eget tempus enim cursus et. Donec tincidunt felis quis ex pretium, a maximus leo finibus. Ut hendrerit massa ut ipsum ornare sodales. Nunc malesuada at nibh vitae malesuada. Phasellus nec justo condimentum, ullamcorper sapien vel, venenatis ligula. Nulla vel arcu ac augue imperdiet finibus sodales dapibus leo.\n'
      'Sed vitae justo et velit venenatis placerat eu vel lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac risus sit amet felis lacinia ullamcorper a quis tellus. Ut ac ipsum fermentum, efficitur nulla sed, bibendum velit. Maecenas sit amet quam diam. Etiam in facilisis orci. Duis nunc mauris, mollis quis ligula in, fringilla tristique mi. Sed eget scelerisque arcu, accumsan mollis metus. Nullam lobortis augue ex, in vestibulum turpis accumsan vitae. Nunc sit amet risus enim. Nunc ac mauris eu diam dignissim vestibulum. Donec libero nisl, sodales eget ex vel, dignissim faucibus leo. Donec quis nulla porta, lacinia purus euismod, suscipit ante. Ut nec ultricies dolor, quis ornare justo. Ut eleifend ex in turpis posuere, sit amet iaculis lacus tempus.\n'
      'Donec feugiat justo eget efficitur laoreet. Mauris eget sapien faucibus, tincidunt ex at, condimentum urna. Vivamus sodales lectus diam, vitae eleifend eros rhoncus vel. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fermentum arcu sed placerat vehicula. Cras maximus eu nibh vitae feugiat. Ut nec sem vel justo lobortis maximus sed vitae ligula. Phasellus ullamcorper lorem id sapien viverra consequat. Donec lobortis eu mi at faucibus.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text('Privacy Policy',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 30)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    ));
  }
}

class TermsCondition extends StatelessWidget {
  final String text =
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam in odio condimentum, pellentesque ex at, condimentum nisi. Aliquam erat volutpat. Proin nisl tellus, egestas sed mi eu, tempus egestas diam. Proin eu suscipit nisl. Cras ac libero ipsum. Curabitur blandit tempor mauris quis laoreet. Etiam at fringilla eros.\n'
      'Maecenas a accumsan nibh. Fusce id lectus a quam placerat porttitor non non enim. Mauris vulputate sodales metus nec pellentesque. Morbi id est vel libero euismod hendrerit nec non urna. Suspendisse at ante ligula. Maecenas commodo mi in interdum lobortis. Aenean gravida luctus enim, eget tempus enim cursus et. Donec tincidunt felis quis ex pretium, a maximus leo finibus. Ut hendrerit massa ut ipsum ornare sodales. Nunc malesuada at nibh vitae malesuada. Phasellus nec justo condimentum, ullamcorper sapien vel, venenatis ligula. Nulla vel arcu ac augue imperdiet finibus sodales dapibus leo.\n'
      'Sed vitae justo et velit venenatis placerat eu vel lectus. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec ac risus sit amet felis lacinia ullamcorper a quis tellus. Ut ac ipsum fermentum, efficitur nulla sed, bibendum velit. Maecenas sit amet quam diam. Etiam in facilisis orci. Duis nunc mauris, mollis quis ligula in, fringilla tristique mi. Sed eget scelerisque arcu, accumsan mollis metus. Nullam lobortis augue ex, in vestibulum turpis accumsan vitae. Nunc sit amet risus enim. Nunc ac mauris eu diam dignissim vestibulum. Donec libero nisl, sodales eget ex vel, dignissim faucibus leo. Donec quis nulla porta, lacinia purus euismod, suscipit ante. Ut nec ultricies dolor, quis ornare justo. Ut eleifend ex in turpis posuere, sit amet iaculis lacus tempus.\n'
      'Donec feugiat justo eget efficitur laoreet. Mauris eget sapien faucibus, tincidunt ex at, condimentum urna. Vivamus sodales lectus diam, vitae eleifend eros rhoncus vel. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin fermentum arcu sed placerat vehicula. Cras maximus eu nibh vitae feugiat. Ut nec sem vel justo lobortis maximus sed vitae ligula. Phasellus ullamcorper lorem id sapien viverra consequat. Donec lobortis eu mi at faucibus.';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 10),
          alignment: Alignment.topLeft,
          padding: const EdgeInsets.all(10),
          child: Text('Terms and Condition',
              textAlign: TextAlign.left,
              style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                  fontSize: 28)),
        ),
        Container(
          padding: const EdgeInsets.all(10),
          child: Text(
            text,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    ));
  }
}
