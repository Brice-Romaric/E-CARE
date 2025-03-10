import 'package:e_care/widgets/async_builder.dart';
import 'package:flutter/material.dart';
import 'package:e_care/models/model.dart';
import 'package:e_care/repositories/repository.dart';
import 'package:e_care/screens/admins/details.dart';
import 'package:e_care/screens/admins/form.dart';

abstract class ManagementScreen<T extends Model> extends StatefulWidget {
  late final String title;
  String? subtitle;
  bool isMasculine = true;
  String? authenticationIdentifier;
  late final Repository<T> repository;
  late final List<String> cardTitleFields;
  late final List<String> cardSubtitleFields;
  late final List<String> onSearchFields;
  late final int maxItems;
  late final dynamic leading;
  late final String? image;
  bool? isAndFilter;
  Map<String, String>? customFilter;

  ManagementScreen({super.key});

  @override
  State<ManagementScreen> createState() => _ManagementScreenState();

  FormScreen buildFormScreen(BuildContext context, String title, dynamic item);

  DetailsScreen buildDetailsScreen(
      BuildContext context, String title, dynamic item);
}

class _ManagementScreenState extends State<ManagementScreen> {
  Future<List<Model>>? filteredItems;

  @override
  void initState() {
    super.initState();
    getItems();
  }

  void performSearchQuery(String query) {
    Map<String, String> customFilter = widget.customFilter ?? {};
    Map<String, String> fields = Map<String, String>.from(customFilter);
    for (var field in widget.onSearchFields) {
      if (!customFilter.containsKey(field)) {
        fields[field] = query;
      }
    }
    setState(() {
      if (query.isEmpty) {
        getItems();
      } else {
        filteredItems = widget.repository
            .search(fields, limit: widget.maxItems, isAnd: false);
      }
    });
  }

  void getItems() {
    Map<String, String> customFilter = widget.customFilter ?? {};
    if (customFilter.isEmpty) {
      filteredItems = widget.repository.getAll(limit: widget.maxItems);
    } else {
      filteredItems = widget.repository.search(customFilter,
          limit: widget.maxItems, isAnd: widget.isAndFilter ?? false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var lowerTitle = widget.title.toLowerCase();
    var capitalTitle = widget.title.toCapitalCase();
    var subtitle = widget.subtitle ?? widget.title;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalTitle,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Liste des $lowerTitle',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              onSubmitted: (value) {
                performSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Chercher des $lowerTitle...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: AsyncBuilder(
                  future: filteredItems,
                  builder: (_, data) {
                    return ListView.separated(
                      itemCount: data.length,
                      // Replace with the number of users
                      itemBuilder: (context, index) {
                        var item = data[index];
                        var title = widget.cardTitleFields
                            .map((field) => item[field])
                            .join(" ");
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        widget.buildDetailsScreen(
                                            context, subtitle, item)));
                          },
                          child: Card(
                            child: ListTile(
                              visualDensity: VisualDensity(vertical: 4),
                              leading: widget.leading != null
                                  ? (widget.leading is IconData
                                      ? Container(
                                          decoration: BoxDecoration(
                                              color: widget.image == null
                                                  ? Colors.greenAccent
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          height:
                                              widget.image == null ? 60 : 100,
                                          width:
                                              widget.image == null ? 60 : 100,
                                          child: widget.image == null
                                              ? Icon(
                                                  widget.leading,
                                                  color: Colors.white,
                                                )
                                              : Image.network(
                                                  item[widget.image!]),
                                        )
                                      : widget.leading)
                                  : null,
                              title: Text(
                                title,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: widget.cardSubtitleFields
                                    .map((field) => Text("${item[field]}",
                                        style: TextStyle(color: Colors.white)))
                                    .toList(),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      Navigator.push<bool>(context,
                                          MaterialPageRoute(builder: (context) {
                                        return widget.buildFormScreen(
                                            context, subtitle, item); // <- item
                                      })).then((result) {
                                        if (result != null && result) {
                                          setState(() {
                                            getItems();
                                          });
                                        }
                                      });
                                    },
                                    icon: const Icon(Icons.edit,
                                        color: Colors.greenAccent),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      widget.repository
                                          .delete(item)
                                          .then((data) {
                                        setState(() {
                                          getItems();
                                        });
                                      });
                                    },
                                    icon: const Icon(Icons.delete,
                                        color: Colors.redAccent),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(
                        height: 16,
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push<bool>(context, MaterialPageRoute(builder: (context) {
            return widget.buildFormScreen(context, subtitle, null); // <- null
          })).then((result) {
            if (result != null && result) {
              setState(() {
                getItems();
              });
            }
          });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
