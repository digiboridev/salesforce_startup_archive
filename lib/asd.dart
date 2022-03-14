class TEntity {
  final int index;
  TEntity({
    required this.index,
  });
}

class TModel extends TEntity {
  TModel({
    required int index,
  }) : super(index: index);

  Map<String, dynamic> toMap() {
    return {
      'index': index,
    };
  }

  factory TModel.fromMap(Map<String, dynamic> map) {
    return TModel(
      index: map['index']?.toInt() ?? 0,
    );
  }
}

class Repo {
  setEnt({required TEntity ent}) {
    var qwe = ent as TModel;
    // qwe.toMap();
    print(qwe.toMap());
  }
}
