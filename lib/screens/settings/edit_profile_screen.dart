import 'package:flutter/material.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:knot/utils/app_theme.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    final user = context.read<MyAuthProvider>().currentUser;
    nameController.text = user?.name ?? '';
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Edit Profile')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(height: 16),
              // ── Avatar ──
              CircleAvatar(
                radius: 48,
                backgroundColor: AppTheme.primary,
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 32),
              // ── Name field ──
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: 'Display Name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (v) => v == null || v.trim().isEmpty
                    ? 'Name cannot be empty'
                    : null,
              ),
              SizedBox(height: 24),
              // ── Save button ──
              Consumer<MyAuthProvider>(
                builder: (context, provider, _) {
                  return provider.loading
                      ? CircularProgressIndicator()
                      : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          provider.updateName(
                              nameController.text.trim());
                        }
                      },
                      child: Text('Save Changes'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}