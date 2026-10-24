import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/pengajuan_cubit.dart';
import '../models/layanan_model.dart';
import '../pages/halaman_beranda.dart';
import '../pages/halaman_layanan.dart';
import '../pages/halaman_warga.dart';

class KerangkaNavigasi extends StatefulWidget {
  const KerangkaNavigasi({super.key});

  @override
  State<KerangkaNavigasi> createState() => _KerangkaNavigasiState();
}

class _KerangkaNavigasiState extends State<KerangkaNavigasi> {
  int _indeksTerpilih = 0;

  final List<Widget> _halaman = const [
    HalamanBeranda(),
    HalamanLayanan(),
    HalamanWarga(),
  ];

  @override
  Widget build(BuildContext context) {
    final bool layarLebar = MediaQuery.of(context).size.width >= 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nusantara Cerdas Mobile'),
        elevation: 2,
      ),
      drawer: layarLebar ? null : _buatDrawer(),
      body: layarLebar
          ? Row(
              children: [
                _buatNavigationRail(),
                const VerticalDivider(thickness: 1, width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _indeksTerpilih,
                    children: _halaman,
                  ),
                ),
              ],
            )
          : IndexedStack(index: _indeksTerpilih, children: _halaman),
      bottomNavigationBar: layarLebar ? null : _buatNavigationBar(),
    );
  }

  Widget _buatBadgeIcon({required IconData iconData}) {
    return BlocSelector<PengajuanCubit, List<ItemPengajuan>, int>(
      selector: (state) => state.length,
      builder: (context, total) {
        return Badge(
          isLabelVisible: total > 0,
          label: Text('$total'),
          child: Icon(iconData),
        );
      },
    );
  }

  Widget _buatNavigationBar() {
    return NavigationBar(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (idx) => setState(() => _indeksTerpilih = idx),
      destinations: [
        const NavigationDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: 'Beranda',
        ),
        const NavigationDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: 'Layanan',
        ),
        NavigationDestination(
          icon: _buatBadgeIcon(iconData: Icons.person_outline),
          selectedIcon: _buatBadgeIcon(iconData: Icons.person),
          label: 'Warga',
        ),
      ],
    );
  }

  Widget _buatNavigationRail() {
    return NavigationRail(
      selectedIndex: _indeksTerpilih,
      onDestinationSelected: (idx) => setState(() => _indeksTerpilih = idx),
      extended: true,
      destinations: [
        const NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text('Beranda'),
        ),
        const NavigationRailDestination(
          icon: Icon(Icons.miscellaneous_services_outlined),
          selectedIcon: Icon(Icons.miscellaneous_services),
          label: Text('Layanan'),
        ),
        NavigationRailDestination(
          icon: _buatBadgeIcon(iconData: Icons.person_outline),
          selectedIcon: _buatBadgeIcon(iconData: Icons.person),
          label: const Text('Warga'),
        ),
      ],
    );
  }

  Widget _buatDrawer() {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.indigo),
            child: Text(
              'Nusantara Cerdas',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Beranda'),
            onTap: () {
              setState(() => _indeksTerpilih = 0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.miscellaneous_services),
            title: const Text('Layanan'),
            onTap: () {
              setState(() => _indeksTerpilih = 1);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: _buatBadgeIcon(iconData: Icons.person),
            title: const Text('Warga'),
            onTap: () {
              setState(() => _indeksTerpilih = 2);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
