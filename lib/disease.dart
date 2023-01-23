import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LettuceDiseases extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade300,
        title: Text('Lettuce Diseases'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            DiseaseCard(
              diseaseName: 'Downy Mildew',
              symptoms: 'Yellow or brown spots on leaves, powdery white growth on the underside of leaves.',
            ),
            DiseaseCard(
              diseaseName: 'Lettuce Mosaic Virus',
              symptoms: 'Yellow or white mottling on leaves, distorted or stunted growth.',
            ),
            DiseaseCard(
              diseaseName: 'Bacterial Leaf Spot',
              symptoms: 'Brown or black spots on leaves, wilting or yellowing of leaves.',
            ),
            DiseaseCard(
              diseaseName: 'Lettuce Aphid',
              symptoms: 'Curled or distorted leaves, honeydew excretion, and sooty mold on leaves.',
            ),
            DiseaseCard(
              diseaseName: 'Lettuce Root Aphid',
              symptoms: 'Yellow or brown leaves, wilting, and stunted growth.',
            ),
          ],
        ),
      ),
    );
  }
}

class DiseaseCard extends StatelessWidget {
  final String diseaseName;
  final String symptoms;

  DiseaseCard({@required this.diseaseName="", @required this.symptoms=""});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diseaseName,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(symptoms),
          ],
        ),
      ),
    );
  }
}
