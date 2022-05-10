import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/core/errors.dart';
import 'package:***REMOVED***/data/models/materials/brand_model.dart';
import 'package:***REMOVED***/data/models/materials/classification_model.dart';
import 'package:***REMOVED***/data/models/materials/family_model.dart';
import 'package:***REMOVED***/data/models/materials/hierarchy_model.dart';
import 'package:***REMOVED***/data/models/materials/material_model.dart';
import 'package:***REMOVED***/data/models/materials/materials_catalog_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class MaterialsRemoteDatasource {
  Future<MaterialsCatalogModel> getCatalog({required String customerSAP});
}

class MaterialsRemoteDatasourceImpl implements MaterialsRemoteDatasource {
  Future subscribeToMaterial({required String customerSAP}) async {
    var response = await SalesforcePlugin.sendRequest(
      endPoint: ***REMOVED***Endpoint,
      path: '/materials/subscribeInventory/$customerSAP',
      method: 'POST',
      payload: {'asd': 'asd'},
    ) as Map<String, dynamic>;

    print(response);
  }

  Future<MaterialsCatalogModel> getCatalog(
      {required String customerSAP}) async {
    try {
      // Get materials list

      Map<String, dynamic> responseList = await SalesforcePlugin.sendRequest(
        endPoint: ***REMOVED***Endpoint,
        path: '/materials/GetMaterialsList/android/$customerSAP',
      ) as Map<String, dynamic>;

      if (responseList['success']) {
        List materialsList = responseList['result']['materialsList'];

        // Split materialsList to chunks
        int len = materialsList.length;
        int size = responseList['result']['chunkSize'];
        List<List> chunks = [];

        for (var i = 0; i < len; i += size) {
          var end = (i + size < len) ? i + size : len;
          chunks.add(materialsList.sublist(i, end));
        }

        // load material data sequentialy

        Set<ClassificationModel> classification = Set();
        Set<BrandModel> brands = Set();
        Set<HierarchyModel> hierarchys = Set();
        Set<FamilyModel> families = Set();
        Set<MaterialModel> materials = Set();

        for (var chunk in chunks) {
          // Chunk loading
          print('Load chunk: ' +
              (chunks.indexOf(chunk) + 1).toString() +
              ' of ' +
              chunks.length.toString());

          Map<String, dynamic> responseMaterials =
              await SalesforcePlugin.sendRequest(
            endPoint: ***REMOVED***Endpoint,
            path: '/materials/catalog/$customerSAP',
            method: 'POST',
            payload: {"materialList": chunk},
          ) as Map<String, dynamic>;

          if (responseMaterials['success']) {
            List cl = responseMaterials['result']['classifications'];
            cl.forEach((element) {
              classification.add(ClassificationModel.fromMap(element));
            });

            List br = responseMaterials['result']['brands'];
            br.forEach((element) {
              brands.add(BrandModel.fromMap(element));
            });

            List hi = responseMaterials['result']['Hierarchys'];
            hi.forEach((element) {
              hierarchys.add(HierarchyModel.fromMap(element));
            });

            List fa = responseMaterials['result']['families'];
            fa.forEach((element) {
              families.add(FamilyModel.fromMap(element));
            });

            List ma = responseMaterials['result']['materials'];
            ma.forEach((element) {
              materials.add(MaterialModel.fromMap(element));
            });
          }
        }

        // Joind data and return

        MaterialsCatalogModel materialsCatalogModel = MaterialsCatalogModel(
            materials: materials.toList(),
            families: families.toList(),
            classifications: classification.toList(),
            brands: brands.toList(),
            hierarchys: hierarchys.toList());
        print(materialsCatalogModel);
        return materialsCatalogModel;
      } else {
        throw ServerException(responseList['errorMsg']);
      }
    } catch (e) {
      throw InternalException(e.toString());
    }
  }
}
