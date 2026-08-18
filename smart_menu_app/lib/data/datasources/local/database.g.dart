// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $RecipeEntitiesTable extends RecipeEntities
    with TableInfo<$RecipeEntitiesTable, RecipeEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecipeEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, createdAt, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recipes';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecipeEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecipeEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecipeEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $RecipeEntitiesTable createAlias(String alias) {
    return $RecipeEntitiesTable(attachedDatabase, alias);
  }
}

class RecipeEntity extends DataClass implements Insertable<RecipeEntity> {
  final String id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RecipeEntity({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RecipeEntitiesCompanion toCompanion(bool nullToAbsent) {
    return RecipeEntitiesCompanion(
      id: Value(id),
      name: Value(name),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RecipeEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecipeEntity(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RecipeEntity copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RecipeEntity(
    id: id ?? this.id,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RecipeEntity copyWithCompanion(RecipeEntitiesCompanion data) {
    return RecipeEntity(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecipeEntity(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, createdAt, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecipeEntity &&
          other.id == this.id &&
          other.name == this.name &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RecipeEntitiesCompanion extends UpdateCompanion<RecipeEntity> {
  final Value<String> id;
  final Value<String> name;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const RecipeEntitiesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecipeEntitiesCompanion.insert({
    required String id,
    required String name,
    required DateTime createdAt,
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RecipeEntity> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecipeEntitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return RecipeEntitiesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecipeEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IngredientEntitiesTable extends IngredientEntities
    with TableInfo<$IngredientEntitiesTable, IngredientEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IngredientEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<String> amount = GeneratedColumn<String>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _scalableMeta = const VerificationMeta(
    'scalable',
  );
  @override
  late final GeneratedColumn<bool> scalable = GeneratedColumn<bool>(
    'scalable',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("scalable" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _precisionMeta = const VerificationMeta(
    'precision',
  );
  @override
  late final GeneratedColumn<String> precision = GeneratedColumn<String>(
    'precision',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _roundingModeMeta = const VerificationMeta(
    'roundingMode',
  );
  @override
  late final GeneratedColumn<String> roundingMode = GeneratedColumn<String>(
    'rounding_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _remarkMeta = const VerificationMeta('remark');
  @override
  late final GeneratedColumn<String> remark = GeneratedColumn<String>(
    'remark',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    name,
    amount,
    unit,
    type,
    scalable,
    precision,
    roundingMode,
    sortOrder,
    remark,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ingredients';
  @override
  VerificationContext validateIntegrity(
    Insertable<IngredientEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    } else if (isInserting) {
      context.missing(_unitMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('scalable')) {
      context.handle(
        _scalableMeta,
        scalable.isAcceptableOrUnknown(data['scalable']!, _scalableMeta),
      );
    }
    if (data.containsKey('precision')) {
      context.handle(
        _precisionMeta,
        precision.isAcceptableOrUnknown(data['precision']!, _precisionMeta),
      );
    } else if (isInserting) {
      context.missing(_precisionMeta);
    }
    if (data.containsKey('rounding_mode')) {
      context.handle(
        _roundingModeMeta,
        roundingMode.isAcceptableOrUnknown(
          data['rounding_mode']!,
          _roundingModeMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_roundingModeMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('remark')) {
      context.handle(
        _remarkMeta,
        remark.isAcceptableOrUnknown(data['remark']!, _remarkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  IngredientEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IngredientEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}amount'],
      )!,
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      scalable: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}scalable'],
      )!,
      precision: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}precision'],
      )!,
      roundingMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rounding_mode'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      remark: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}remark'],
      )!,
    );
  }

  @override
  $IngredientEntitiesTable createAlias(String alias) {
    return $IngredientEntitiesTable(attachedDatabase, alias);
  }
}

class IngredientEntity extends DataClass
    implements Insertable<IngredientEntity> {
  final String id;
  final String recipeId;
  final String name;
  final String amount;
  final String unit;
  final String type;
  final bool scalable;
  final String precision;
  final String roundingMode;
  final int sortOrder;
  final String remark;
  const IngredientEntity({
    required this.id,
    required this.recipeId,
    required this.name,
    required this.amount,
    required this.unit,
    required this.type,
    required this.scalable,
    required this.precision,
    required this.roundingMode,
    required this.sortOrder,
    required this.remark,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['name'] = Variable<String>(name);
    map['amount'] = Variable<String>(amount);
    map['unit'] = Variable<String>(unit);
    map['type'] = Variable<String>(type);
    map['scalable'] = Variable<bool>(scalable);
    map['precision'] = Variable<String>(precision);
    map['rounding_mode'] = Variable<String>(roundingMode);
    map['sort_order'] = Variable<int>(sortOrder);
    map['remark'] = Variable<String>(remark);
    return map;
  }

  IngredientEntitiesCompanion toCompanion(bool nullToAbsent) {
    return IngredientEntitiesCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      name: Value(name),
      amount: Value(amount),
      unit: Value(unit),
      type: Value(type),
      scalable: Value(scalable),
      precision: Value(precision),
      roundingMode: Value(roundingMode),
      sortOrder: Value(sortOrder),
      remark: Value(remark),
    );
  }

  factory IngredientEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IngredientEntity(
      id: serializer.fromJson<String>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      name: serializer.fromJson<String>(json['name']),
      amount: serializer.fromJson<String>(json['amount']),
      unit: serializer.fromJson<String>(json['unit']),
      type: serializer.fromJson<String>(json['type']),
      scalable: serializer.fromJson<bool>(json['scalable']),
      precision: serializer.fromJson<String>(json['precision']),
      roundingMode: serializer.fromJson<String>(json['roundingMode']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      remark: serializer.fromJson<String>(json['remark']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'name': serializer.toJson<String>(name),
      'amount': serializer.toJson<String>(amount),
      'unit': serializer.toJson<String>(unit),
      'type': serializer.toJson<String>(type),
      'scalable': serializer.toJson<bool>(scalable),
      'precision': serializer.toJson<String>(precision),
      'roundingMode': serializer.toJson<String>(roundingMode),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'remark': serializer.toJson<String>(remark),
    };
  }

  IngredientEntity copyWith({
    String? id,
    String? recipeId,
    String? name,
    String? amount,
    String? unit,
    String? type,
    bool? scalable,
    String? precision,
    String? roundingMode,
    int? sortOrder,
    String? remark,
  }) => IngredientEntity(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    name: name ?? this.name,
    amount: amount ?? this.amount,
    unit: unit ?? this.unit,
    type: type ?? this.type,
    scalable: scalable ?? this.scalable,
    precision: precision ?? this.precision,
    roundingMode: roundingMode ?? this.roundingMode,
    sortOrder: sortOrder ?? this.sortOrder,
    remark: remark ?? this.remark,
  );
  IngredientEntity copyWithCompanion(IngredientEntitiesCompanion data) {
    return IngredientEntity(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      name: data.name.present ? data.name.value : this.name,
      amount: data.amount.present ? data.amount.value : this.amount,
      unit: data.unit.present ? data.unit.value : this.unit,
      type: data.type.present ? data.type.value : this.type,
      scalable: data.scalable.present ? data.scalable.value : this.scalable,
      precision: data.precision.present ? data.precision.value : this.precision,
      roundingMode: data.roundingMode.present
          ? data.roundingMode.value
          : this.roundingMode,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      remark: data.remark.present ? data.remark.value : this.remark,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IngredientEntity(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('type: $type, ')
          ..write('scalable: $scalable, ')
          ..write('precision: $precision, ')
          ..write('roundingMode: $roundingMode, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('remark: $remark')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    recipeId,
    name,
    amount,
    unit,
    type,
    scalable,
    precision,
    roundingMode,
    sortOrder,
    remark,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IngredientEntity &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.name == this.name &&
          other.amount == this.amount &&
          other.unit == this.unit &&
          other.type == this.type &&
          other.scalable == this.scalable &&
          other.precision == this.precision &&
          other.roundingMode == this.roundingMode &&
          other.sortOrder == this.sortOrder &&
          other.remark == this.remark);
}

class IngredientEntitiesCompanion extends UpdateCompanion<IngredientEntity> {
  final Value<String> id;
  final Value<String> recipeId;
  final Value<String> name;
  final Value<String> amount;
  final Value<String> unit;
  final Value<String> type;
  final Value<bool> scalable;
  final Value<String> precision;
  final Value<String> roundingMode;
  final Value<int> sortOrder;
  final Value<String> remark;
  final Value<int> rowid;
  const IngredientEntitiesCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.name = const Value.absent(),
    this.amount = const Value.absent(),
    this.unit = const Value.absent(),
    this.type = const Value.absent(),
    this.scalable = const Value.absent(),
    this.precision = const Value.absent(),
    this.roundingMode = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IngredientEntitiesCompanion.insert({
    required String id,
    required String recipeId,
    required String name,
    required String amount,
    required String unit,
    required String type,
    this.scalable = const Value.absent(),
    required String precision,
    required String roundingMode,
    this.sortOrder = const Value.absent(),
    this.remark = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recipeId = Value(recipeId),
       name = Value(name),
       amount = Value(amount),
       unit = Value(unit),
       type = Value(type),
       precision = Value(precision),
       roundingMode = Value(roundingMode);
  static Insertable<IngredientEntity> custom({
    Expression<String>? id,
    Expression<String>? recipeId,
    Expression<String>? name,
    Expression<String>? amount,
    Expression<String>? unit,
    Expression<String>? type,
    Expression<bool>? scalable,
    Expression<String>? precision,
    Expression<String>? roundingMode,
    Expression<int>? sortOrder,
    Expression<String>? remark,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (name != null) 'name': name,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (type != null) 'type': type,
      if (scalable != null) 'scalable': scalable,
      if (precision != null) 'precision': precision,
      if (roundingMode != null) 'rounding_mode': roundingMode,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (remark != null) 'remark': remark,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IngredientEntitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? recipeId,
    Value<String>? name,
    Value<String>? amount,
    Value<String>? unit,
    Value<String>? type,
    Value<bool>? scalable,
    Value<String>? precision,
    Value<String>? roundingMode,
    Value<int>? sortOrder,
    Value<String>? remark,
    Value<int>? rowid,
  }) {
    return IngredientEntitiesCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      unit: unit ?? this.unit,
      type: type ?? this.type,
      scalable: scalable ?? this.scalable,
      precision: precision ?? this.precision,
      roundingMode: roundingMode ?? this.roundingMode,
      sortOrder: sortOrder ?? this.sortOrder,
      remark: remark ?? this.remark,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (amount.present) {
      map['amount'] = Variable<String>(amount.value);
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (scalable.present) {
      map['scalable'] = Variable<bool>(scalable.value);
    }
    if (precision.present) {
      map['precision'] = Variable<String>(precision.value);
    }
    if (roundingMode.present) {
      map['rounding_mode'] = Variable<String>(roundingMode.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (remark.present) {
      map['remark'] = Variable<String>(remark.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('IngredientEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('name: $name, ')
          ..write('amount: $amount, ')
          ..write('unit: $unit, ')
          ..write('type: $type, ')
          ..write('scalable: $scalable, ')
          ..write('precision: $precision, ')
          ..write('roundingMode: $roundingMode, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('remark: $remark, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CookingStepEntitiesTable extends CookingStepEntities
    with TableInfo<$CookingStepEntitiesTable, CookingStepEntity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CookingStepEntitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recipeIdMeta = const VerificationMeta(
    'recipeId',
  );
  @override
  late final GeneratedColumn<String> recipeId = GeneratedColumn<String>(
    'recipe_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES recipes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _stepNoMeta = const VerificationMeta('stepNo');
  @override
  late final GeneratedColumn<int> stepNo = GeneratedColumn<int>(
    'step_no',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _contentMeta = const VerificationMeta(
    'content',
  );
  @override
  late final GeneratedColumn<String> content = GeneratedColumn<String>(
    'content',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    recipeId,
    stepNo,
    content,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cooking_steps';
  @override
  VerificationContext validateIntegrity(
    Insertable<CookingStepEntity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('recipe_id')) {
      context.handle(
        _recipeIdMeta,
        recipeId.isAcceptableOrUnknown(data['recipe_id']!, _recipeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_recipeIdMeta);
    }
    if (data.containsKey('step_no')) {
      context.handle(
        _stepNoMeta,
        stepNo.isAcceptableOrUnknown(data['step_no']!, _stepNoMeta),
      );
    } else if (isInserting) {
      context.missing(_stepNoMeta);
    }
    if (data.containsKey('content')) {
      context.handle(
        _contentMeta,
        content.isAcceptableOrUnknown(data['content']!, _contentMeta),
      );
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CookingStepEntity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CookingStepEntity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      recipeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recipe_id'],
      )!,
      stepNo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}step_no'],
      )!,
      content: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}content'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $CookingStepEntitiesTable createAlias(String alias) {
    return $CookingStepEntitiesTable(attachedDatabase, alias);
  }
}

class CookingStepEntity extends DataClass
    implements Insertable<CookingStepEntity> {
  final String id;
  final String recipeId;
  final int stepNo;
  final String content;
  final int sortOrder;
  const CookingStepEntity({
    required this.id,
    required this.recipeId,
    required this.stepNo,
    required this.content,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['recipe_id'] = Variable<String>(recipeId);
    map['step_no'] = Variable<int>(stepNo);
    map['content'] = Variable<String>(content);
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  CookingStepEntitiesCompanion toCompanion(bool nullToAbsent) {
    return CookingStepEntitiesCompanion(
      id: Value(id),
      recipeId: Value(recipeId),
      stepNo: Value(stepNo),
      content: Value(content),
      sortOrder: Value(sortOrder),
    );
  }

  factory CookingStepEntity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CookingStepEntity(
      id: serializer.fromJson<String>(json['id']),
      recipeId: serializer.fromJson<String>(json['recipeId']),
      stepNo: serializer.fromJson<int>(json['stepNo']),
      content: serializer.fromJson<String>(json['content']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'recipeId': serializer.toJson<String>(recipeId),
      'stepNo': serializer.toJson<int>(stepNo),
      'content': serializer.toJson<String>(content),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  CookingStepEntity copyWith({
    String? id,
    String? recipeId,
    int? stepNo,
    String? content,
    int? sortOrder,
  }) => CookingStepEntity(
    id: id ?? this.id,
    recipeId: recipeId ?? this.recipeId,
    stepNo: stepNo ?? this.stepNo,
    content: content ?? this.content,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  CookingStepEntity copyWithCompanion(CookingStepEntitiesCompanion data) {
    return CookingStepEntity(
      id: data.id.present ? data.id.value : this.id,
      recipeId: data.recipeId.present ? data.recipeId.value : this.recipeId,
      stepNo: data.stepNo.present ? data.stepNo.value : this.stepNo,
      content: data.content.present ? data.content.value : this.content,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CookingStepEntity(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNo: $stepNo, ')
          ..write('content: $content, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, recipeId, stepNo, content, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CookingStepEntity &&
          other.id == this.id &&
          other.recipeId == this.recipeId &&
          other.stepNo == this.stepNo &&
          other.content == this.content &&
          other.sortOrder == this.sortOrder);
}

class CookingStepEntitiesCompanion extends UpdateCompanion<CookingStepEntity> {
  final Value<String> id;
  final Value<String> recipeId;
  final Value<int> stepNo;
  final Value<String> content;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const CookingStepEntitiesCompanion({
    this.id = const Value.absent(),
    this.recipeId = const Value.absent(),
    this.stepNo = const Value.absent(),
    this.content = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CookingStepEntitiesCompanion.insert({
    required String id,
    required String recipeId,
    required int stepNo,
    required String content,
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       recipeId = Value(recipeId),
       stepNo = Value(stepNo),
       content = Value(content);
  static Insertable<CookingStepEntity> custom({
    Expression<String>? id,
    Expression<String>? recipeId,
    Expression<int>? stepNo,
    Expression<String>? content,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (recipeId != null) 'recipe_id': recipeId,
      if (stepNo != null) 'step_no': stepNo,
      if (content != null) 'content': content,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CookingStepEntitiesCompanion copyWith({
    Value<String>? id,
    Value<String>? recipeId,
    Value<int>? stepNo,
    Value<String>? content,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return CookingStepEntitiesCompanion(
      id: id ?? this.id,
      recipeId: recipeId ?? this.recipeId,
      stepNo: stepNo ?? this.stepNo,
      content: content ?? this.content,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (recipeId.present) {
      map['recipe_id'] = Variable<String>(recipeId.value);
    }
    if (stepNo.present) {
      map['step_no'] = Variable<int>(stepNo.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CookingStepEntitiesCompanion(')
          ..write('id: $id, ')
          ..write('recipeId: $recipeId, ')
          ..write('stepNo: $stepNo, ')
          ..write('content: $content, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $RecipeEntitiesTable recipeEntities = $RecipeEntitiesTable(this);
  late final $IngredientEntitiesTable ingredientEntities =
      $IngredientEntitiesTable(this);
  late final $CookingStepEntitiesTable cookingStepEntities =
      $CookingStepEntitiesTable(this);
  late final RecipeDao recipeDao = RecipeDao(this as AppDatabase);
  late final IngredientDao ingredientDao = IngredientDao(this as AppDatabase);
  late final CookingStepDao cookingStepDao = CookingStepDao(
    this as AppDatabase,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    recipeEntities,
    ingredientEntities,
    cookingStepEntities,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ingredients', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'recipes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('cooking_steps', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$RecipeEntitiesTableCreateCompanionBuilder =
    RecipeEntitiesCompanion Function({
      required String id,
      required String name,
      required DateTime createdAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$RecipeEntitiesTableUpdateCompanionBuilder =
    RecipeEntitiesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

final class $$RecipeEntitiesTableReferences
    extends BaseReferences<_$AppDatabase, $RecipeEntitiesTable, RecipeEntity> {
  $$RecipeEntitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$IngredientEntitiesTable, List<IngredientEntity>>
  _ingredientEntitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.ingredientEntities,
        aliasName: 'recipes__id__ingredients__recipe_id',
      );

  $$IngredientEntitiesTableProcessedTableManager get ingredientEntitiesRefs {
    final manager = $$IngredientEntitiesTableTableManager(
      $_db,
      $_db.ingredientEntities,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _ingredientEntitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CookingStepEntitiesTable, List<CookingStepEntity>>
  _cookingStepEntitiesRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cookingStepEntities,
        aliasName: 'recipes__id__cooking_steps__recipe_id',
      );

  $$CookingStepEntitiesTableProcessedTableManager get cookingStepEntitiesRefs {
    final manager = $$CookingStepEntitiesTableTableManager(
      $_db,
      $_db.cookingStepEntities,
    ).filter((f) => f.recipeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cookingStepEntitiesRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RecipeEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $RecipeEntitiesTable> {
  $$RecipeEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ingredientEntitiesRefs(
    Expression<bool> Function($$IngredientEntitiesTableFilterComposer f) f,
  ) {
    final $$IngredientEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ingredientEntities,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$IngredientEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.ingredientEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cookingStepEntitiesRefs(
    Expression<bool> Function($$CookingStepEntitiesTableFilterComposer f) f,
  ) {
    final $$CookingStepEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cookingStepEntities,
      getReferencedColumn: (t) => t.recipeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CookingStepEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.cookingStepEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RecipeEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $RecipeEntitiesTable> {
  $$RecipeEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecipeEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecipeEntitiesTable> {
  $$RecipeEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  Expression<T> ingredientEntitiesRefs<T extends Object>(
    Expression<T> Function($$IngredientEntitiesTableAnnotationComposer a) f,
  ) {
    final $$IngredientEntitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.ingredientEntities,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$IngredientEntitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.ingredientEntities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> cookingStepEntitiesRefs<T extends Object>(
    Expression<T> Function($$CookingStepEntitiesTableAnnotationComposer a) f,
  ) {
    final $$CookingStepEntitiesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.cookingStepEntities,
          getReferencedColumn: (t) => t.recipeId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$CookingStepEntitiesTableAnnotationComposer(
                $db: $db,
                $table: $db.cookingStepEntities,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RecipeEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecipeEntitiesTable,
          RecipeEntity,
          $$RecipeEntitiesTableFilterComposer,
          $$RecipeEntitiesTableOrderingComposer,
          $$RecipeEntitiesTableAnnotationComposer,
          $$RecipeEntitiesTableCreateCompanionBuilder,
          $$RecipeEntitiesTableUpdateCompanionBuilder,
          (RecipeEntity, $$RecipeEntitiesTableReferences),
          RecipeEntity,
          PrefetchHooks Function({
            bool ingredientEntitiesRefs,
            bool cookingStepEntitiesRefs,
          })
        > {
  $$RecipeEntitiesTableTableManager(
    _$AppDatabase db,
    $RecipeEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecipeEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecipeEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecipeEntitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecipeEntitiesCompanion(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => RecipeEntitiesCompanion.insert(
                id: id,
                name: name,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RecipeEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                ingredientEntitiesRefs = false,
                cookingStepEntitiesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (ingredientEntitiesRefs) db.ingredientEntities,
                    if (cookingStepEntitiesRefs) db.cookingStepEntities,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (ingredientEntitiesRefs)
                        await $_getPrefetchedData<
                          RecipeEntity,
                          $RecipeEntitiesTable,
                          IngredientEntity
                        >(
                          currentTable: table,
                          referencedTable: $$RecipeEntitiesTableReferences
                              ._ingredientEntitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipeEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).ingredientEntitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (cookingStepEntitiesRefs)
                        await $_getPrefetchedData<
                          RecipeEntity,
                          $RecipeEntitiesTable,
                          CookingStepEntity
                        >(
                          currentTable: table,
                          referencedTable: $$RecipeEntitiesTableReferences
                              ._cookingStepEntitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RecipeEntitiesTableReferences(
                                db,
                                table,
                                p0,
                              ).cookingStepEntitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.recipeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$RecipeEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecipeEntitiesTable,
      RecipeEntity,
      $$RecipeEntitiesTableFilterComposer,
      $$RecipeEntitiesTableOrderingComposer,
      $$RecipeEntitiesTableAnnotationComposer,
      $$RecipeEntitiesTableCreateCompanionBuilder,
      $$RecipeEntitiesTableUpdateCompanionBuilder,
      (RecipeEntity, $$RecipeEntitiesTableReferences),
      RecipeEntity,
      PrefetchHooks Function({
        bool ingredientEntitiesRefs,
        bool cookingStepEntitiesRefs,
      })
    >;
typedef $$IngredientEntitiesTableCreateCompanionBuilder =
    IngredientEntitiesCompanion Function({
      required String id,
      required String recipeId,
      required String name,
      required String amount,
      required String unit,
      required String type,
      Value<bool> scalable,
      required String precision,
      required String roundingMode,
      Value<int> sortOrder,
      Value<String> remark,
      Value<int> rowid,
    });
typedef $$IngredientEntitiesTableUpdateCompanionBuilder =
    IngredientEntitiesCompanion Function({
      Value<String> id,
      Value<String> recipeId,
      Value<String> name,
      Value<String> amount,
      Value<String> unit,
      Value<String> type,
      Value<bool> scalable,
      Value<String> precision,
      Value<String> roundingMode,
      Value<int> sortOrder,
      Value<String> remark,
      Value<int> rowid,
    });

final class $$IngredientEntitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $IngredientEntitiesTable,
          IngredientEntity
        > {
  $$IngredientEntitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipeEntitiesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipeEntities.createAlias('ingredients__recipe_id__recipes__id');

  $$RecipeEntitiesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipeEntitiesTableTableManager(
      $_db,
      $_db.recipeEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$IngredientEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $IngredientEntitiesTable> {
  $$IngredientEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get scalable => $composableBuilder(
    column: $table.scalable,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get precision => $composableBuilder(
    column: $table.precision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get roundingMode => $composableBuilder(
    column: $table.roundingMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipeEntitiesTableFilterComposer get recipeId {
    final $$RecipeEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $IngredientEntitiesTable> {
  $$IngredientEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get scalable => $composableBuilder(
    column: $table.scalable,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get precision => $composableBuilder(
    column: $table.precision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get roundingMode => $composableBuilder(
    column: $table.roundingMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get remark => $composableBuilder(
    column: $table.remark,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipeEntitiesTableOrderingComposer get recipeId {
    final $$RecipeEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $IngredientEntitiesTable> {
  $$IngredientEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<bool> get scalable =>
      $composableBuilder(column: $table.scalable, builder: (column) => column);

  GeneratedColumn<String> get precision =>
      $composableBuilder(column: $table.precision, builder: (column) => column);

  GeneratedColumn<String> get roundingMode => $composableBuilder(
    column: $table.roundingMode,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<String> get remark =>
      $composableBuilder(column: $table.remark, builder: (column) => column);

  $$RecipeEntitiesTableAnnotationComposer get recipeId {
    final $$RecipeEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$IngredientEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $IngredientEntitiesTable,
          IngredientEntity,
          $$IngredientEntitiesTableFilterComposer,
          $$IngredientEntitiesTableOrderingComposer,
          $$IngredientEntitiesTableAnnotationComposer,
          $$IngredientEntitiesTableCreateCompanionBuilder,
          $$IngredientEntitiesTableUpdateCompanionBuilder,
          (IngredientEntity, $$IngredientEntitiesTableReferences),
          IngredientEntity,
          PrefetchHooks Function({bool recipeId})
        > {
  $$IngredientEntitiesTableTableManager(
    _$AppDatabase db,
    $IngredientEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$IngredientEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$IngredientEntitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$IngredientEntitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String> amount = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<bool> scalable = const Value.absent(),
                Value<String> precision = const Value.absent(),
                Value<String> roundingMode = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<String> remark = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientEntitiesCompanion(
                id: id,
                recipeId: recipeId,
                name: name,
                amount: amount,
                unit: unit,
                type: type,
                scalable: scalable,
                precision: precision,
                roundingMode: roundingMode,
                sortOrder: sortOrder,
                remark: remark,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recipeId,
                required String name,
                required String amount,
                required String unit,
                required String type,
                Value<bool> scalable = const Value.absent(),
                required String precision,
                required String roundingMode,
                Value<int> sortOrder = const Value.absent(),
                Value<String> remark = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IngredientEntitiesCompanion.insert(
                id: id,
                recipeId: recipeId,
                name: name,
                amount: amount,
                unit: unit,
                type: type,
                scalable: scalable,
                precision: precision,
                roundingMode: roundingMode,
                sortOrder: sortOrder,
                remark: remark,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$IngredientEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$IngredientEntitiesTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$IngredientEntitiesTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$IngredientEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $IngredientEntitiesTable,
      IngredientEntity,
      $$IngredientEntitiesTableFilterComposer,
      $$IngredientEntitiesTableOrderingComposer,
      $$IngredientEntitiesTableAnnotationComposer,
      $$IngredientEntitiesTableCreateCompanionBuilder,
      $$IngredientEntitiesTableUpdateCompanionBuilder,
      (IngredientEntity, $$IngredientEntitiesTableReferences),
      IngredientEntity,
      PrefetchHooks Function({bool recipeId})
    >;
typedef $$CookingStepEntitiesTableCreateCompanionBuilder =
    CookingStepEntitiesCompanion Function({
      required String id,
      required String recipeId,
      required int stepNo,
      required String content,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$CookingStepEntitiesTableUpdateCompanionBuilder =
    CookingStepEntitiesCompanion Function({
      Value<String> id,
      Value<String> recipeId,
      Value<int> stepNo,
      Value<String> content,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$CookingStepEntitiesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $CookingStepEntitiesTable,
          CookingStepEntity
        > {
  $$CookingStepEntitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RecipeEntitiesTable _recipeIdTable(_$AppDatabase db) =>
      db.recipeEntities.createAlias('cooking_steps__recipe_id__recipes__id');

  $$RecipeEntitiesTableProcessedTableManager get recipeId {
    final $_column = $_itemColumn<String>('recipe_id')!;

    final manager = $$RecipeEntitiesTableTableManager(
      $_db,
      $_db.recipeEntities,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_recipeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CookingStepEntitiesTableFilterComposer
    extends Composer<_$AppDatabase, $CookingStepEntitiesTable> {
  $$CookingStepEntitiesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get stepNo => $composableBuilder(
    column: $table.stepNo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$RecipeEntitiesTableFilterComposer get recipeId {
    final $$RecipeEntitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableFilterComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CookingStepEntitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $CookingStepEntitiesTable> {
  $$CookingStepEntitiesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get stepNo => $composableBuilder(
    column: $table.stepNo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get content => $composableBuilder(
    column: $table.content,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$RecipeEntitiesTableOrderingComposer get recipeId {
    final $$RecipeEntitiesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableOrderingComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CookingStepEntitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CookingStepEntitiesTable> {
  $$CookingStepEntitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get stepNo =>
      $composableBuilder(column: $table.stepNo, builder: (column) => column);

  GeneratedColumn<String> get content =>
      $composableBuilder(column: $table.content, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$RecipeEntitiesTableAnnotationComposer get recipeId {
    final $$RecipeEntitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.recipeId,
      referencedTable: $db.recipeEntities,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RecipeEntitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.recipeEntities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CookingStepEntitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CookingStepEntitiesTable,
          CookingStepEntity,
          $$CookingStepEntitiesTableFilterComposer,
          $$CookingStepEntitiesTableOrderingComposer,
          $$CookingStepEntitiesTableAnnotationComposer,
          $$CookingStepEntitiesTableCreateCompanionBuilder,
          $$CookingStepEntitiesTableUpdateCompanionBuilder,
          (CookingStepEntity, $$CookingStepEntitiesTableReferences),
          CookingStepEntity,
          PrefetchHooks Function({bool recipeId})
        > {
  $$CookingStepEntitiesTableTableManager(
    _$AppDatabase db,
    $CookingStepEntitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CookingStepEntitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CookingStepEntitiesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$CookingStepEntitiesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> recipeId = const Value.absent(),
                Value<int> stepNo = const Value.absent(),
                Value<String> content = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CookingStepEntitiesCompanion(
                id: id,
                recipeId: recipeId,
                stepNo: stepNo,
                content: content,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String recipeId,
                required int stepNo,
                required String content,
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CookingStepEntitiesCompanion.insert(
                id: id,
                recipeId: recipeId,
                stepNo: stepNo,
                content: content,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CookingStepEntitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({recipeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (recipeId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.recipeId,
                        referencedTable: $$CookingStepEntitiesTableReferences
                            ._recipeIdTable(db),
                        referencedColumn: $$CookingStepEntitiesTableReferences
                            ._recipeIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CookingStepEntitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CookingStepEntitiesTable,
      CookingStepEntity,
      $$CookingStepEntitiesTableFilterComposer,
      $$CookingStepEntitiesTableOrderingComposer,
      $$CookingStepEntitiesTableAnnotationComposer,
      $$CookingStepEntitiesTableCreateCompanionBuilder,
      $$CookingStepEntitiesTableUpdateCompanionBuilder,
      (CookingStepEntity, $$CookingStepEntitiesTableReferences),
      CookingStepEntity,
      PrefetchHooks Function({bool recipeId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$RecipeEntitiesTableTableManager get recipeEntities =>
      $$RecipeEntitiesTableTableManager(_db, _db.recipeEntities);
  $$IngredientEntitiesTableTableManager get ingredientEntities =>
      $$IngredientEntitiesTableTableManager(_db, _db.ingredientEntities);
  $$CookingStepEntitiesTableTableManager get cookingStepEntities =>
      $$CookingStepEntitiesTableTableManager(_db, _db.cookingStepEntities);
}

mixin _$RecipeDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipeEntitiesTable get recipeEntities => attachedDatabase.recipeEntities;
  RecipeDaoManager get managers => RecipeDaoManager(this);
}

class RecipeDaoManager {
  final _$RecipeDaoMixin _db;
  RecipeDaoManager(this._db);
  $$RecipeEntitiesTableTableManager get recipeEntities =>
      $$RecipeEntitiesTableTableManager(
        _db.attachedDatabase,
        _db.recipeEntities,
      );
}

mixin _$IngredientDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipeEntitiesTable get recipeEntities => attachedDatabase.recipeEntities;
  $IngredientEntitiesTable get ingredientEntities =>
      attachedDatabase.ingredientEntities;
  IngredientDaoManager get managers => IngredientDaoManager(this);
}

class IngredientDaoManager {
  final _$IngredientDaoMixin _db;
  IngredientDaoManager(this._db);
  $$RecipeEntitiesTableTableManager get recipeEntities =>
      $$RecipeEntitiesTableTableManager(
        _db.attachedDatabase,
        _db.recipeEntities,
      );
  $$IngredientEntitiesTableTableManager get ingredientEntities =>
      $$IngredientEntitiesTableTableManager(
        _db.attachedDatabase,
        _db.ingredientEntities,
      );
}

mixin _$CookingStepDaoMixin on DatabaseAccessor<AppDatabase> {
  $RecipeEntitiesTable get recipeEntities => attachedDatabase.recipeEntities;
  $CookingStepEntitiesTable get cookingStepEntities =>
      attachedDatabase.cookingStepEntities;
  CookingStepDaoManager get managers => CookingStepDaoManager(this);
}

class CookingStepDaoManager {
  final _$CookingStepDaoMixin _db;
  CookingStepDaoManager(this._db);
  $$RecipeEntitiesTableTableManager get recipeEntities =>
      $$RecipeEntitiesTableTableManager(
        _db.attachedDatabase,
        _db.recipeEntities,
      );
  $$CookingStepEntitiesTableTableManager get cookingStepEntities =>
      $$CookingStepEntitiesTableTableManager(
        _db.attachedDatabase,
        _db.cookingStepEntities,
      );
}
