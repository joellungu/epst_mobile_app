import 'package:epst_app/vues/bibliotheques/models/bibliotheque_classe.dart';
import 'package:epst_app/vues/bibliotheques/models/bibliotheque_cours.dart';
import 'package:epst_app/vues/bibliotheques/services/bibliotheque_service.dart';
import 'package:epst_app/vues/bibliotheques/widgets/bibliotheque_empty_state.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';

class BibliothequeCoursPage extends StatefulWidget {
  final BibliothequeClasse classe;
  final BibliothequeService service;
  final String propriete;

  const BibliothequeCoursPage({
    Key? key,
    required this.classe,
    required this.service,
    required this.propriete,
  }) : super(key: key);

  @override
  State<BibliothequeCoursPage> createState() => _BibliothequeCoursPageState();
}

class _BibliothequeCoursPageState extends State<BibliothequeCoursPage> {
  late Future<List<BibliothequeCours>> _future;
  int? _openingCourseId;

  @override
  void initState() {
    super.initState();
    _future = widget.service.getCoursesByClass(
      widget.classe.id,
      widget.propriete,
    );
  }

  Future<void> _refresh() async {
    setState(() {
      _future = widget.service.getCoursesByClass(
        widget.classe.id,
        widget.propriete,
        refresh: true,
      );
    });
    await _future;
  }

  Future<void> _openCourse(BibliothequeCours cours) async {
    if (cours.isZip) {
      return;
    }

    setState(() {
      _openingCourseId = cours.id;
    });

    try {
      final file = await widget.service.getOrDownloadCourseFile(cours);
      final result = await OpenFile.open(
        file.path,
        type: _mimeType(cours.extension),
      );
      if (result.type != ResultType.done) {
        Get.snackbar(
          'Ouverture impossible',
          result.message,
          backgroundColor: Colors.orange.shade100,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Cours indisponible',
        '$e',
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      if (mounted) {
        setState(() {
          _openingCourseId = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      appBar: AppBar(
        title: Text(
          widget.classe.nom,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: FutureBuilder<List<BibliothequeCours>>(
        future: _future,
        builder: (context, snapshot) {
          final courses = snapshot.data ?? [];

          return RefreshIndicator(
            onRefresh: _refresh,
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(18, 14, 18, 8),
                    child: Text(
                      '${courses.length} fichier${courses.length > 1 ? 's' : ''} associe${courses.length > 1 ? 's' : ''}',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                if (snapshot.connectionState == ConnectionState.waiting &&
                    courses.isEmpty)
                  const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (courses.isEmpty)
                  const SliverFillRemaining(
                    child: BibliothequeEmptyState(
                      icon: Icons.folder_open,
                      title: 'Aucun fichier pour cette classe',
                      message:
                          'Tirez vers le bas pour verifier les derniers fichiers en ligne.',
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(14, 4, 14, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final cours = courses[index];
                          return _CoursTile(
                            cours: cours,
                            loading: _openingCourseId == cours.id,
                            onTap: () => _openCourse(cours),
                          );
                        },
                        childCount: courses.length,
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  String? _mimeType(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return 'application/pdf';
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'mp3':
        return 'audio/mpeg';
      case 'wav':
        return 'audio/wav';
      case 'png':
        return 'image/png';
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
    }
    return null;
  }
}

class _CoursTile extends StatelessWidget {
  final BibliothequeCours cours;
  final bool loading;
  final VoidCallback onTap;

  const _CoursTile({
    Key? key,
    required this.cours,
    required this.loading,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: ListTile(
        onTap: loading ? null : onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        leading: Container(
          height: 42,
          width: 42,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(_iconFor(cours.extension), color: Colors.blue),
        ),
        title: Text(
          cours.titre,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF14213D),
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            cours.detail.isEmpty
                ? cours.extension.toUpperCase()
                : '${cours.detail}\n${cours.extension.toUpperCase()}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        trailing: loading
            ? const SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            : const Icon(Icons.open_in_new),
      ),
    );
  }

  IconData _iconFor(String extension) {
    switch (extension.toLowerCase()) {
      case 'pdf':
        return Icons.picture_as_pdf_outlined;
      case 'mp4':
      case 'mov':
      case 'avi':
      case 'mkv':
        return Icons.play_circle_outline;
      case 'mp3':
      case 'wav':
      case 'aac':
        return Icons.audiotrack_outlined;
      case 'png':
      case 'jpg':
      case 'jpeg':
        return Icons.image_outlined;
      default:
        return Icons.insert_drive_file_outlined;
    }
  }
}
