import 'package:flutter/material.dart';
import 'package:knot/provider/auth/my_auth_provider.dart';
import 'package:knot/utils/app_theme.dart';
import 'package:knot/utils/route_helper.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<MyAuthProvider>();
      if (provider.currentUser == null) {
        provider.reloadUser();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        actions: [
          TextButton.icon(
            onPressed: () => _confirmLogout(context),
            icon: Icon(Icons.logout_rounded, color: Colors.red.shade300, size: 20),
            label: Text(
              'Logout',
              style: TextStyle(
                color: Colors.red.shade300,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 8),
        ],
      ),
      body: Consumer<MyAuthProvider>(
        builder: (context, provider, _) {
          // Show loader while fetching
          if (provider.currentUser == null) {
            return Center(child: CircularProgressIndicator());
          }

          final user = provider.currentUser!;

          return ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(height: 48),

              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 56,
                      backgroundColor: AppTheme.primary,
                      child: Text(
                        _getInitials(user.name),
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 4,
                      right: 4,
                      child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppTheme.background, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Center(
                child: Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textPrimary,
                  ),
                ),
              ),

              SizedBox(height: 6),

              Center(
                child: Text(
                  user.email,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppTheme.textSecondary,
                  ),
                ),
              ),

              SizedBox(height: 28),

              Center(
                child: OutlinedButton.icon(
                  onPressed: () =>
                      Navigator.pushNamed(context, RouteHelper.editProfile),
                  icon: Icon(Icons.edit_outlined, size: 18),
                  label: Text('Edit Profile'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.primary,
                    side: BorderSide(color: AppTheme.primary, width: 1.5),
                    padding: EdgeInsets.symmetric(
                        horizontal: 28, vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 48),

              Divider(color: Color(0xFFE2D9C8)),

              SizedBox(height: 24),

              _InfoTile(
                icon: Icons.person_outline,
                label: 'Name',
                value: user.name,
              ),
              SizedBox(height: 12),
              _InfoTile(
                icon: Icons.email_outlined,
                label: 'Email',
                value: user.email,
              ),
              SizedBox(height: 12),
              _InfoTile(
                icon: Icons.calendar_today_outlined,
                label: 'Member since',
                value: _formatDate(user.createdAt),
              ),
            ],
          );
        },
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return '?';
    final parts = name.trim().split(' ');
    if (parts.length == 1) return parts[0][0].toUpperCase();
    return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        title: Text('Logout?'),
        content: Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade400),
            onPressed: () {
              Navigator.pop(context);
              context.read<MyAuthProvider>().logout();
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: AppTheme.inputFill,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Color(0xFFE2D9C8), width: 1),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppTheme.primary.withOpacity(0.7)),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: AppTheme.textSecondary,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.4,
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}