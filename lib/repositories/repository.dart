import 'package:e_care/models/model.dart';

/// Recherche exacte
const int searchTypeExact = 0x01;

/// Ignorer la casse
const int searchTypeIgnoreCase = 0x02;

/// Commence par
const int searchTypeStartsWith = 0x04;

/// Se termine par
const int searchTypeEndsWith = 0x08;

/// Contient
const int searchTypeContains = 0x10;

/// Classe de base pour tous les repository,
/// definissant ainsi les differentes operations de base (CRUD).
abstract class Repository<T extends Model> {
  /// Methode pour l'ajout ou la creation d'un
  /// objet a la base de donnees pour ce model
  Future<T> create(dynamic item);

  /// Methode pour la lecture d'un objet de la base de
  /// donnees par [(ID ou objet)] pour ce model
  Future<T?> getById(dynamic item);

  /// Methode pour la lecture de tous les objets de la base de
  /// donnees pour ce model
  Future<List<T>> getAll({int? limit});

  /// Methode pour la modification d'un objet existant dans
  /// a la base de donnees pour ce model
  Future<T> update(dynamic item);

  /// Methode pour la suppression d'un objet de la base de
  /// donnees par [(ID ou objet)] pour ce model
  Future<void> delete(dynamic item, {bool onCascade = true});

  /// Methode pour la recherche par filtre des objets de la base de
  /// donnees pour ce model
  Future<List<T>> search(Map<String, dynamic> filters,
      {int? limit,
      int? offset,
      Map<String, int>? searchTypes,
      int defaultType = searchTypeExact,
      bool isAnd = true});

  /// Methode pour la lecture de tous les objets d'une relation
  /// plusieur a plusieur pour ce model [(ID ou objet)]
  Future<List<M>> getManyMany<M extends Model>(dynamic item,
      String relationName, {String? tableName});

  /// Methode pour l'ajout d'objets d'une relation
  /// plusieur a plusieur pour ce model [(ID ou objet)]
  Future<void> addManyMany<M extends Model>(dynamic item, String relationName,
      {List<dynamic>? others, bool continueOnError = false, String? tableName});

  /// Methode pour la suppression d'objets d'une relation
  /// plusieur a plusieur pour ce model [(ID ou objet)]
  Future<void> removeManyMany<M extends Model>(
      dynamic item, String relationName,
      {List<dynamic>? others,
      bool continueOnError = false,
      String? tableName,
      bool all = false});

  /// Methode pour la lecture de tous les objets d'une relation
  /// un a plusieur pour ce model [(ID ou objet)]
  Future<List<M>> getMany<M extends Model>(dynamic item, {String? tableName});

  /// Methode pour l'ajout d'objets d'une relation
  /// un a plusieur pour ce model [(ID ou objet)]
  Future<void> addMany<M extends Model>(dynamic item,
      {List<dynamic>? others, bool continueOnError = false, String? tableName});

  /// Methode pour la suppression d'objets d'une relation
  /// plusieur a plusieur pour ce model [(ID ou objet)]
  Future<void> removeMany<M extends Model>(dynamic item,
      {List<dynamic>? others,
      bool continueOnError = false,
      String? tableName,
      bool all = false});

  /// Methode pour la lecture d'un objet d'une relation
  /// un a un pour ce model [(ID ou objet)]
  Future<M?> getOne<M extends Model>(dynamic item, {String? tableName});

  /// Methode pour l'ajout d'un objet d'une relation
  /// un a un pour ce model [(ID ou objet)]
  Future<T?> setOne<M extends Model>(item, other, {String? tableName});

  /// Methode pour la suppression d'un objet d'une relation
  /// un a un pour ce model [(ID ou objet)]
  Future<T?> removeOne<M extends Model>(dynamic item, {String? tableName});

  static get instance => throw UnimplementedError();
}
