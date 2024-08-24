import 'package:flutter/material.dart';

class CompanyPoliciesScreen extends StatefulWidget {
  static const id = 'CompanyPoliciesScreen';

  @override
  State<CompanyPoliciesScreen> createState() => _CompanyPoliciesScreenState();
}

class _CompanyPoliciesScreenState extends State<CompanyPoliciesScreen> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Company Policies'),
        flexibleSpace: Container(
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Container(
            padding: EdgeInsets.only(top: 10, left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PolicyCard(
                  title:
                      'The standard Lorem Ipsum passage, used since the 1500s',
                  description:
                      '"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna '
                      'aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute ',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),
                SizedBox(height: 20.0),
                PolicyCard(
                  title:
                      'Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                  description:
                      'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam,'
                      ' eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia ',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),
                SizedBox(height: 20.0),
                PolicyCard(
                  title:
                      'Section 1.10.33 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                  description:
                      'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et '
                      'quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),

                SizedBox(height: 20.0),
                PolicyCard(
                  title:
                      'Section 1.10.32 of "de Finibus Bonorum et Malorum", written by Cicero in 45 BC',
                  description:
                      'At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos'
                      ' dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est '
                      'laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque ',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),
                SizedBox(height: 20.0),
                PolicyCard(
                  title: '1914 translation by H. Rackham',
                  description:
                      'But I must explain to you how all this mistaken idea of denouncing pleasure'
                      ' and praising pain was born and I will give you a complete account of the system, and expound the'
                      ' actual teachings of the great explorer of the truth, the master-builder of human happiness. No one rejects, '
                      'dislikes, or avoids pleasure itself, because it is pleasure, but because those who do not know how to pursue pleasure'
                      ' rationally encounter consequences that are extremely painful. Nor again is there anyone who loves or pursues or desires',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),
                SizedBox(height: 20.0),
                PolicyCard(
                  title: 'Security Policy',
                  description:
                      'Our security policy outlines the measures we take to protect our systems and data.',
                  onTap: () {
                    // Navigate to detailed policy screen
                  },
                ),

                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 0),
                      child: Checkbox(
                        value: _isChecked,
                        checkColor: Colors.white,
                        activeColor: Color.fromARGB(255, 170, 58, 151),
                        onChanged: (value) {
                          setState(() {
                            _isChecked = value!;
                          });
                        },
                      ),
                    ),
                    Text('You have read all policies of company'),
                  ],
                ),

                // Padding(
                //   padding: const EdgeInsets.only(top: 10,right: 0,left: 0,bottom: 20),
                //   child: RoundButton(title: 'Continue', onTap: (){
                //     //Navigator.push(context, MaterialPageRoute(builder: (context) => HoomePage()));
                //   }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PolicyCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback onTap;

  const PolicyCard({
    Key? key,
    required this.title,
    required this.description,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // elevation: 2.0,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
