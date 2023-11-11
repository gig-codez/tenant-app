import 'package:nyumbayo_app/exports/exports.dart';

import 'Inventory.dart';

class Preview extends StatefulWidget {
  const Preview({super.key});

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      value: 0,
      duration: const Duration(milliseconds: 900),
    );
    _controller?.forward();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payments Preview"),
      ),
      body: StreamBuilder(
        stream: Stream.periodic(const Duration(seconds: 1)),
        builder: (context, snapshot) {
          var result = snapshot.data;
          return snapshot.hasData
              ? result!.isEmpty
                  ? const NoDataWidget(text: "No payments available")
                  : ListView.separated(
                      itemBuilder: (ctx, i) {
                        return ListTile(
                          leading: const Icon(Icons.monetization_on),
                          title: Text(
                              "Amount currently paid: ${result[i].amountPaid.toString()}"),
                          subtitle: Text(formatDateTime(
                              DateTime.parse(result[i].createdAt.toString()))),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Inventory(
                                  amountPaid: result[i].amountPaid.toString(),
                                  date: formatDateTime(DateTime.parse(
                                      result[i].createdAt.toString())),
                                  paymentMode: result[i].toString(),
                                  paymentStatus: double.parse(
                                              result[i].balance.toString()) ==
                                          0
                                      ? "Cleared"
                                      : "You have outsanding balances",
                                  property:
                                      (result[i].property.name.toString()),
                                  tenantName: result[i].tenant.name.toString(),
                                  balance: result[i].balance.toString(),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      separatorBuilder: (ctx, i) => const Divider(),
                      itemCount: result.length)
              : const Loader(
                  text: "payment inventory",
                );
        },
      ),
    );
  }
}
