import 'package:***REMOVED***/core/constants.dart';
import 'package:***REMOVED***/data/models/materials/brand_model.dart';
import 'package:***REMOVED***/data/models/materials/classification_model.dart';
import 'package:***REMOVED***/data/models/materials/family_model.dart';
import 'package:***REMOVED***/data/models/materials/hierarchy_model.dart';
import 'package:***REMOVED***/data/models/materials/material_model.dart';
import 'package:salesforce/salesforce.dart';

abstract class MaterialsRemoteDatasource {
  Future getCatalog({required String customerSAP});
}

class MaterialsRemoteDatasourceImpl implements MaterialsRemoteDatasource {
  Future getCatalog({required String customerSAP}) async {
    Map<String, dynamic> responseList = await SalesforcePlugin.sendRequest(
      endPoint: ***REMOVED***Endpoint,
      path: '/materials/GetMaterialsList/android/$customerSAP',
    ) as Map<String, dynamic>;

    if (responseList['success']) {
      List asd = responseList['result']['materialsList'];

      print(asd);

      int len = asd.length;
      int size = 50; //TODO use chunk size from response after api fix
      List<List> chunks = [];

      for (var i = 0; i < len; i += size) {
        var end = (i + size < len) ? i + size : len;
        chunks.add(asd.sublist(i, end));
      }

      print(chunks);

      List materialsChuncks = [];

      Set<ClassificationModel> classification = Set();
      Set<BrandModel> brands = Set();
      Set<HierarchyModel> hierarchys = Set();
      Set<FamilyModel> families = Set();
      Set<MaterialModel> materials = Set();

      for (var chunk in chunks) {
        Map<String, dynamic> responseMaterials =
            await SalesforcePlugin.sendRequest(
          endPoint: ***REMOVED***Endpoint,
          path: '/materials/catalog/$customerSAP',
          method: 'POST',
          payload: {"materialList": chunk},
        ) as Map<String, dynamic>;

        print(responseMaterials);

        if (responseMaterials['success']) {
          materialsChuncks.add(responseMaterials['result']);

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
      print(classification);
    }
  }
}
