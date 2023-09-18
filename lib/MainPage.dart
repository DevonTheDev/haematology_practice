import 'package:flutter/material.dart';

class PortfolioApp extends StatelessWidget {
  const PortfolioApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Developer Portfolio',
      theme: ThemeData(
        primaryColor: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const PortfolioPage(),
    );
  }
}

class PortfolioPage extends StatelessWidget {
  const PortfolioPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color.fromARGB(255, 0, 255, 255), Color.fromARGB(255, 255, 0, 140)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Center everything
              children: <Widget>[
                HeaderSection(),
                SizedBox(height: 20),
                ProjectsSection(),
                SizedBox(height: 20),
                ContactSection(),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeaderSection extends StatelessWidget {
  const HeaderSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('assets/westward_logo.png'),
          ),
          SizedBox(height: 20),
          Text(
            'Westward Code',
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Define your list of projects here
    List<ProjectItem> _projects = [
      ProjectItem(
        title: 'Project 1',
        description: 'Description of Project 1',
        dateAdded: DateTime(2023, 9, 1),
        language: 'Dart',
        image: 'assets/project1_image.png', // Provide image path or URL
      ),
      ProjectItem(
        title: 'Project 2',
        description: 'Description of Project 2',
        dateAdded: DateTime(2023, 8, 15),
        language: 'Flutter',
        image: 'assets/project2_image.png', // Provide image path or URL
      ),
      // Add more ProjectItem widgets for additional projects
    ];

    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the text
        children: <Widget>[
          Text(
            'Projects',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: _projects.length,
            itemBuilder: (context, index) {
              final project = _projects[index];
              return ProjectItem(
                title: project.title,
                description: project.description,
                dateAdded: project.dateAdded,
                language: project.language,
                image: project.image,
              );
            },
          ),
          // Add more ProjectItem widgets for additional projects
        ],
      ),
    );
  }
}

class ProjectItem extends StatelessWidget {
  final String title;
  final String description;
  final DateTime dateAdded;
  final String language;
  final String image; // Add image path or URL

  const ProjectItem({
    Key? key,
    required this.title,
    required this.description,
    required this.dateAdded,
    required this.language,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Image.asset(
            image, // Use AssetImage or NetworkImage depending on your needs
            height: 100, // Adjust the height as needed
          ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          Text(
            'Date Added: ${dateAdded.toString().substring(0, 10)}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Language: $language',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            description,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }
}

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Center the text
        children: <Widget>[
          Text(
            'Contact',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Email: your.email@example.com',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center, // Center the text
          ),
          Text(
            'LinkedIn: linkedin.com/in/yourprofile',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            textAlign: TextAlign.center, // Center the text
          ),
          // Add more contact information as needed
        ],
      ),
    );
  }
}