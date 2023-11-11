// import 'dart:convert';

import '/exports/exports.dart';
import 'ViewComplaint.dart';

class Complaint extends StatefulWidget {
  const Complaint({super.key});

  @override
  State<Complaint> createState() => _ComplaintState();
}

class _ComplaintState extends State<Complaint> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 18.0, top: 20, bottom: 20),
              child: Text(
                "Complaints",
                style: TextStyles(context)
                    .getTitleStyle()
                    .copyWith(fontWeight: FontWeight.w600),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                  future: fetchComplaints(""),
                  builder: (context, s) {
                    var data = s.data;
                    // return s.hasData == false
                    return s.hasData == false
                        ? const Loader(
                            text: "Complaints",
                          )
                        : s.data!.isEmpty
                            ? const NoDataWidget(
                                text: "No Complaints",
                              )
                            : ListView.builder(
                                itemCount: data?.length,
                                itemBuilder: (ctx, i) {
                                  var t = data?[i];
                                  return ListTile(
                                    onTap: () {
                                      Routes.push(
                                        ViewComplaint(
                                          title: t!.complaintName,
                                          description: t.complaintDescription,
                                          status: t.complaintStatus,
                                          image: t.complaintImage,
                                          date: t.createdAt.toString(),
                                        ),
                                        context,
                                      );
                                    },
                                    leading: const CircleAvatar(
                                      radius: 40,
                                      // backgroundImage: MemoryImage(
                                      //   base64.decode(
                                      //     t?['image'],
                                      //   ),
                                      // ),
                                    ),
                                    title: Text(t!.complaintName,
                                        style: TextStyles(context)
                                            .getRegularStyle()),
                                    subtitle: Text(
                                        getTimeAgo(
                                          t.createdAt.subtract(
                                            const Duration(seconds: 1),
                                          ),
                                        ),
                                        style: TextStyles(context)
                                            .getDescriptionStyle()),
                                    trailing: Text(
                                        t.complaintStatus.characters.first
                                                .toUpperCase() +
                                            t.complaintStatus.substring(1),
                                        style: TextStyles(context)
                                            .getDescriptionStyle()),
                                  );
                                });
                  }),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Routes.push(const AddComplaint(), context),
        icon: const Icon(Icons.add),
        label: const Text("Add Complaint"),
      ),
    );
  }
}
