import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        
        title: Center(child: const Text('Admin Dashboard', style: TextStyle(fontSize: 35, fontWeight:FontWeight.bold),)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Manage Attractions
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage Attractions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('destinationDetails')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        var attractions = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: attractions.length,
                          itemBuilder: (context, index) {
                            var attraction = attractions[index].data() as Map<String, dynamic>;
                            var attractionId = attractions[index].id;
                            return ListTile(
                              title: Text(attraction['locationName']),
                              subtitle: Text(attraction['city']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _editAttraction(context, attractionId, attraction);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      _deleteAttraction(attractionId);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Add New Attraction Button
            ElevatedButton(
              onPressed: () {
                _addAttraction(context);
              },
              child: const Text('Add New Attraction'),
            ),
            const SizedBox(height: 20),
            // Manage Reviews
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Manage Reviews',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collectionGroup('reviews')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
                        }
                        var reviews = snapshot.data!.docs;
                        return ListView.builder(
                          itemCount: reviews.length,
                          itemBuilder: (context, index) {
                            var review = reviews[index].data() as Map<String, dynamic>;
                            return ListTile(
                              title: Text(review['comment']),
                              subtitle: Text('Rating: ${review['rating']}'),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteReview(reviews[index].reference);
                                },
                              ),
                            );
                          },
                        );
                      },
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

  void _addAttraction(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController cityController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add New Attraction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Location Name'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance.collection('destinationDetails').add({
                  'locationName': nameController.text,
                  'city': cityController.text,
                  'description': descriptionController.text,
                  'distance': '0 km', // Default value
                  'timings': '9 AM - 5 PM', // Default value
                  'location': '0,0', // Default value
                });
                Navigator.pop(context);
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editAttraction(BuildContext context, String attractionId, Map<String, dynamic> attraction) {
    TextEditingController nameController = TextEditingController(text: attraction['locationName']);
    TextEditingController cityController = TextEditingController(text: attraction['city']);
    TextEditingController descriptionController = TextEditingController(text: attraction['description']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Attraction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Location Name'),
              ),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(labelText: 'City'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('destinationDetails')
                    .doc(attractionId)
                    .update({
                  'locationName': nameController.text,
                  'city': cityController.text,
                  'description': descriptionController.text,
                });
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _deleteAttraction(String attractionId) {
    FirebaseFirestore.instance
        .collection('destinationDetails')
        .doc(attractionId)
        .delete();
  }

  void _deleteReview(DocumentReference reviewRef) {
    reviewRef.delete();
  }
}