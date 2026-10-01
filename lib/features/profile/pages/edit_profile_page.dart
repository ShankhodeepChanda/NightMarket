import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:night_market/core/constants/app_spacing.dart';
import 'package:night_market/core/constants/app_radius.dart';
import 'package:night_market/core/services/auth_service.dart';
import 'package:night_market/features/profile/models/user_profile.dart';
import 'package:night_market/features/profile/services/profile_service.dart';

/// A list of suggested skills to pick from.
///
/// Users may also type custom skills; these are starting suggestions.
const List<String> kSuggestedSkills = [
  'Web Development',
  'Mobile Development',
  'UI/UX Design',
  'Graphic Design',
  'Photography',
  'Video Editing',
  'Content Writing',
  'Social Media',
  'Data Science',
  'Machine Learning',
  'Tutoring',
  'Music',
  'Event Management',
  'Marketing',
  'Animation',
];

/// Maximum number of skills a user can select.
const int kMaxSkills = 5;

/// Form page for creating or editing a user profile.
///
/// When [existingProfile] is null the page acts as a "Create Profile" flow;
/// otherwise it pre-fills the form with the current values.
class EditProfilePage extends StatefulWidget {
  final UserProfile? existingProfile;

  /// Optional overrides for tests.
  final ProfileService? profileService;
  final AuthService? authService;

  const EditProfilePage({
    super.key,
    this.existingProfile,
    this.profileService,
    this.authService,
  });

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();

  late final ProfileService _profileService;
  late final AuthService _authService;

  late final TextEditingController _nameController;
  late final TextEditingController _collegeController;
  late final TextEditingController _bioController;

  final List<String> _selectedSkills = [];
  File? _pickedImage;
  bool _isSaving = false;

  bool get _isEditing => widget.existingProfile != null;

  @override
  void initState() {
    super.initState();
    _profileService = widget.profileService ?? ProfileService();
    _authService = widget.authService ?? AuthService();

    final profile = widget.existingProfile;
    _nameController = TextEditingController(text: profile?.name ?? '');
    _collegeController = TextEditingController(text: profile?.college ?? '');
    _bioController = TextEditingController(text: profile?.bio ?? '');

    if (profile != null) {
      _selectedSkills.addAll(profile.skills);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _collegeController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  // ---------------------------------------------------------------------------
  // Actions
  // ---------------------------------------------------------------------------

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 75,
    );
    if (picked != null) {
      setState(() {
        _pickedImage = File(picked.path);
      });
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final user = _authService.currentUser;
      if (user == null) {
        _showError('You are not signed in.');
        return;
      }

      String? photoUrl = widget.existingProfile?.photoUrl;

      // Upload image if user picked a new one.
      if (_pickedImage != null) {
        photoUrl = await _profileService.uploadProfilePicture(
          user.uid,
          _pickedImage!,
        );
      }

      final profileData = {
        'name': _nameController.text.trim(),
        'college': _collegeController.text.trim(),
        'bio': _bioController.text.trim(),
        'skills': _selectedSkills,
      };

      if (photoUrl != null) {
        profileData['photoUrl'] = photoUrl;
      }

      if (_isEditing) {
        await _profileService.updateUserProfile(user.uid, profileData);
      } else {
        final newProfile = UserProfile(
          id: user.uid,
          name: _nameController.text.trim(),
          email: user.email ?? '',
          photoUrl: photoUrl,
          bio: _bioController.text.trim(),
          college: _collegeController.text.trim(),
          skills: _selectedSkills,
        );
        await _profileService.createUserProfile(newProfile);
      }

      if (mounted) {
        Navigator.of(context).pop(true); // signal success
      }
    } catch (e) {
      _showError('Failed to save profile. Please try again.');
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // ---------------------------------------------------------------------------
  // Skills
  // ---------------------------------------------------------------------------

  void _toggleSkill(String skill) {
    setState(() {
      if (_selectedSkills.contains(skill)) {
        _selectedSkills.remove(skill);
      } else if (_selectedSkills.length < kMaxSkills) {
        _selectedSkills.add(skill);
      }
    });
  }

  // ---------------------------------------------------------------------------
  // Build
  // ---------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Profile' : 'Create Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- Profile picture ---
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundColor: colorScheme.primaryContainer,
                        backgroundImage:
                            _pickedImage != null ? FileImage(_pickedImage!) : null,
                        child: _pickedImage == null
                            ? Icon(
                                Icons.person,
                                size: 50,
                                color: colorScheme.onPrimaryContainer,
                              )
                            : null,
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // --- Name ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Your full name',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),

              // --- College ---
              TextFormField(
                controller: _collegeController,
                decoration: const InputDecoration(
                  labelText: 'College',
                  hintText: 'Your college or university',
                  prefixIcon: Icon(Icons.school_outlined),
                ),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.md),

              // --- Bio ---
              TextFormField(
                controller: _bioController,
                decoration: const InputDecoration(
                  labelText: 'Bio',
                  hintText: 'Tell others about yourself',
                  prefixIcon: Icon(Icons.info_outline),
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                maxLength: 200,
              ),
              const SizedBox(height: AppSpacing.lg),

              // --- Skills ---
              Text(
                'Skills (up to $kMaxSkills)',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                '${_selectedSkills.length}/$kMaxSkills selected',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: kSuggestedSkills.map((skill) {
                  final isSelected = _selectedSkills.contains(skill);
                  return FilterChip(
                    label: Text(skill),
                    selected: isSelected,
                    onSelected: (_) => _toggleSkill(skill),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // --- Save button ---
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isSaving ? null : _save,
                  child: _isSaving
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                        )
                      : Text(_isEditing ? 'Save Changes' : 'Create Profile'),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}
