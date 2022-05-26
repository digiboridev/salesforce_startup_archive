import 'package:***REMOVED***/domain/entities/favorites/favorite_list.dart';
import 'package:***REMOVED***/domain/entities/materials/material.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_controller.dart';
import 'package:***REMOVED***/presentation/controllers/favorites_states.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_controller.dart';
import 'package:***REMOVED***/presentation/controllers/materials_catalog_states.dart';
import 'package:***REMOVED***/presentation/ui/screens/main_screen/favorites/new_fav_list_bottomsheet.dart';
import 'package:get/get.dart';

class FavoritesPageController extends GetxController {
  // Dependency
  FavoritesController _favoritesController = Get.find();
  MaterialsCatalogController _materialsCatalogController = Get.find();

  // variables
  RxnInt _selectedListIndex = RxnInt();
  int? get selectedListIndex => _selectedListIndex.value;

  RxBool _recomendedListSelected = RxBool(false);
  bool get recomendedListSelected => _recomendedListSelected.value;

  RxList<Materiale> _recomendedMaterials = RxList();
  List<Materiale> get recomendedMaterials => _recomendedMaterials;

  RxList<FavoriteList> _favoriteLists = RxList();
  List<FavoriteList> get favoriteLists => _favoriteLists;

  @override
  void onReady() {
    super.onReady();

    updateFavoritesLists(fcstate: _favoritesController.state);
    _favoritesController.stateStream.listen((fcstate) {
      updateFavoritesLists(fcstate: fcstate);
    });

    updateRecomendedMaterials(
        mcstate: _materialsCatalogController.materialsCatalogState.value);
    _materialsCatalogController.materialsCatalogState.listen((mcstate) {
      updateRecomendedMaterials(mcstate: mcstate);
    });
  }

  updateFavoritesLists({required FavoritesState fcstate}) {
    if (fcstate is FSCommon) {
      _favoriteLists.value = fcstate.favoriteLists;
      // update selection of lists on changes
      if (_selectedListIndex.value != null) {
        if (_selectedListIndex.value! > fcstate.favoriteLists.length - 1) {
          // select first list if last list been deleted
          if (fcstate.favoriteLists.isNotEmpty) {
            _selectedListIndex.value = 0;
          } else {
            _selectedListIndex.value = null;
          }
        }
      } else {
        if (fcstate.favoriteLists.isNotEmpty && !recomendedListSelected) {
          _selectedListIndex.value = 0;
        } else {
          _selectedListIndex.value = null;
        }
      }
    } else {
      _favoriteLists.value = [];
      _selectedListIndex.value = null;
    }
  }

  updateRecomendedMaterials({required MaterialsCatalogState mcstate}) {
    if (mcstate is MCSCommon) {
      // TODO uncomment on api ready
      //       _recomendedMaterials.value = mcstate.catalog.materials
      // .where((element) => element.AverageQty > 0)
      // .toList();
      _recomendedMaterials.value = mcstate.catalog.materials.take(10).toList();
    } else {
      _recomendedMaterials.value = [];
    }
  }

  // Materials to show based on favorites list selection
  List<Materiale> get materialsToShow {
    List<Materiale> materials = [];

    MaterialsCatalogState mcstate =
        _materialsCatalogController.materialsCatalogState.value;

    if (mcstate is MCSCommon) {
      if (_recomendedListSelected.value) {
        materials = recomendedMaterials;
      } else {
        if (selectedListIndex != null) {
          FavoriteList listToShow =
              _favoriteLists.elementAt(selectedListIndex!);

          listToShow.favoriteItems.forEach((fi) {
            Materiale? m = mcstate.catalog.materials.firstWhereOrNull(
              (material) => material.MaterialNumber == fi.materialNumber,
            );

            if (m is Materiale) {
              materials.add(m);
            }
          });
        }
      }
    }

    return materials;
  }

  selectList({required int index}) {
    _recomendedListSelected.value = false;
    _selectedListIndex.value = index;
  }

  selectRecomended() {
    _recomendedListSelected.value = true;
    _selectedListIndex.value = null;
  }

  showAddNewList() {
    Get.bottomSheet(NewFavoritesListBottomheet()).then((value) {
      if (value is String) {
        _favoritesController.addNewBlancList(listName: value);
      }
    });
  }
}
