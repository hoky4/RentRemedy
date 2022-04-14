import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request.dart';
import 'package:rentremedy_mobile/Model/Maintenance/maintenance_request_status.dart';
import 'package:rentremedy_mobile/Providers/api_service_provider.dart';
import 'package:rentremedy_mobile/View/Maintenance/view_maintenance_request_screen.dart';

class ViewMaintenanceRequestsScreen extends StatefulWidget {
  const ViewMaintenanceRequestsScreen({Key? key}) : super(key: key);

  @override
  _ViewMaintenanceRequestsScreenState createState() =>
      _ViewMaintenanceRequestsScreenState();
}

class _ViewMaintenanceRequestsScreenState
    extends State<ViewMaintenanceRequestsScreen>
    with AutomaticKeepAliveClientMixin<ViewMaintenanceRequestsScreen> {
  late ApiServiceProvider apiService;

  late List<MaintenanceRequest> maintenanceRequests;
  late bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = Provider.of<ApiServiceProvider>(context, listen: false);
    maintenanceRequests = [];
    fetchMaintenanceRequests();
  }

  Future fetchMaintenanceRequests() async {
    try {
      List<MaintenanceRequest> maintenanceRequestList =
        await apiService.getAllMaintenanceRequests();
      if (mounted) {
        setState(() {
          maintenanceRequests = maintenanceRequestList;
          isLoading = false;
        });
      }
    } on Exception catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                "Problem getting maintenance request: ${e.toString()}")));
      }
  }

  @override
  Widget build(BuildContext context) {
    return !isLoading
        ? Scaffold(
            backgroundColor: Theme.of(context).primaryColor,
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/maintenanceRequest');
                },
                tooltip: 'File Maintenance Request',
                child: const Icon(Icons.add)),
            body: Column(children: [
              if (maintenanceRequests.isEmpty) ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: 1,
                          itemBuilder: (context, index) => const ListTile(
                                title: Text("No maintenance requests yet"),
                              )),
                      onRefresh: fetchMaintenanceRequests,
                    ),
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RefreshIndicator(
                      child: ListView.builder(
                          itemCount: maintenanceRequests.length,
                          itemBuilder: (context, index) =>
                              MaintenanceRequestItem(
                                  maintenanceRequest:
                                      maintenanceRequests[index])),
                      onRefresh: fetchMaintenanceRequests,
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

class MaintenanceRequestItem extends StatelessWidget {
  MaintenanceRequest maintenanceRequest;
  MaintenanceRequestItem({Key? key, required this.maintenanceRequest})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        color: Theme.of(context).dividerColor,
        child: ListTile(
          title: Text(
            maintenanceRequest.item,
            style: const TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            'Status: ${maintenanceRequest.status.value}',
            style: const TextStyle(color: Colors.white70),
          ),
          onTap: () {
            Navigator.pushNamed(context, '/viewMaintenanceRequest',
                arguments:
                    ViewMaintenanceRequestScreenArguments(maintenanceRequest));
          },
        ));
  }
}
