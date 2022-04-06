import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Auth/logged_in_user.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/lease_agreement.dart';
import 'package:rentremedy_mobile/Model/LeaseAgreement/status.dart';
import 'package:rentremedy_mobile/View/Onboarding/join_screen.dart';
import '../../Providers/api_service_provider.dart';

class ViewLeaseAgreementsScreen extends StatefulWidget {
  const ViewLeaseAgreementsScreen({Key? key}) : super(key: key);

  @override
  State<ViewLeaseAgreementsScreen> createState() =>
      _ViewLeaseAgreementsScreenState();
}

class _ViewLeaseAgreementsScreenState extends State<ViewLeaseAgreementsScreen> {
  late ApiServiceProvider apiService;

  late List<LeaseAgreement> leaseAgreements;
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    leaseAgreements = [];
    fetchLeaseAgreements();
  }

  Future fetchLeaseAgreements() async {
    LoggedInUser user = apiService.authModelProvider.user!;
    List<LeaseAgreement> leaseAgreementList =
        await apiService.findAllLeaseAgreements();
    if (mounted) {
      setState(() {
        leaseAgreements = leaseAgreementList;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Lease Agreements"),
              backgroundColor: Theme.of(context).primaryColorDark,
            ),
            backgroundColor: Theme.of(context).primaryColor,
            body: Column(children: [
              if (leaseAgreements.isEmpty) ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => const ListTile(
                                title: Text("No Lease Agreements Yet"),
                              )),
                      onRefresh: fetchLeaseAgreements,
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: leaseAgreements.length,
                          itemBuilder: (context, index) => LeaseAgreementItem(
                              leaseAgreement: leaseAgreements[index])),
                      onRefresh: fetchLeaseAgreements,
                    ),
                  ),
                ),
              ]
            ]),
          )
        : Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            body: const Center(child: CircularProgressIndicator()));
  }

  @override
  bool get wantKeepAlive => true;
}

class LeaseAgreementItem extends StatelessWidget {
  LeaseAgreement leaseAgreement;
  LeaseAgreementItem({Key? key, required this.leaseAgreement})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).dividerColor,
        child: ListTile(
          title: Text(
            "${DateFormat.yMMMMd('en_US').format(leaseAgreement.startDate.toLocal())} to ${DateFormat.yMMMMd('en_US').format(leaseAgreement.endDate.toLocal())}",
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Status: ${leaseAgreement.status.value}',
            style: const TextStyle(color: Colors.white70),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/terms',
                arguments: JoinScreenArguments(leaseAgreement));
          },
        ));
  }
}
