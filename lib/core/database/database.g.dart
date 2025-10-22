// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ActiveTimersTable extends ActiveTimers
    with TableInfo<$ActiveTimersTable, ActiveTimer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActiveTimersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _alarmMelodyMeta = const VerificationMeta(
    'alarmMelody',
  );
  @override
  late final GeneratedColumn<String> alarmMelody = GeneratedColumn<String>(
    'alarm_melody',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isRunningMeta = const VerificationMeta(
    'isRunning',
  );
  @override
  late final GeneratedColumn<bool> isRunning = GeneratedColumn<bool>(
    'is_running',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_running" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> remainDuration =
      GeneratedColumn<int>(
        'remain_duration',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Duration>($ActiveTimersTable.$converterremainDuration);
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> setDuration =
      GeneratedColumn<int>(
        'set_duration',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Duration>($ActiveTimersTable.$convertersetDuration);
  @override
  List<GeneratedColumn> get $columns => [
    alarmMelody,
    id,
    label,
    isRunning,
    remainDuration,
    setDuration,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'active_timers';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActiveTimer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alarm_melody')) {
      context.handle(
        _alarmMelodyMeta,
        alarmMelody.isAcceptableOrUnknown(
          data['alarm_melody']!,
          _alarmMelodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alarmMelodyMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    if (data.containsKey('is_running')) {
      context.handle(
        _isRunningMeta,
        isRunning.isAcceptableOrUnknown(data['is_running']!, _isRunningMeta),
      );
    } else if (isInserting) {
      context.missing(_isRunningMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActiveTimer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActiveTimer(
      alarmMelody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alarm_melody'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      isRunning: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_running'],
      )!,
      remainDuration: $ActiveTimersTable.$converterremainDuration.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}remain_duration'],
        )!,
      ),
      setDuration: $ActiveTimersTable.$convertersetDuration.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}set_duration'],
        )!,
      ),
    );
  }

  @override
  $ActiveTimersTable createAlias(String alias) {
    return $ActiveTimersTable(attachedDatabase, alias);
  }

  static TypeConverter<Duration, int> $converterremainDuration =
      const DurationConverter();
  static TypeConverter<Duration, int> $convertersetDuration =
      const DurationConverter();
}

class ActiveTimer extends DataClass implements Insertable<ActiveTimer> {
  final String alarmMelody;
  final String id;
  final String label;
  final bool isRunning;
  final Duration remainDuration;
  final Duration setDuration;
  const ActiveTimer({
    required this.alarmMelody,
    required this.id,
    required this.label,
    required this.isRunning,
    required this.remainDuration,
    required this.setDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alarm_melody'] = Variable<String>(alarmMelody);
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    map['is_running'] = Variable<bool>(isRunning);
    {
      map['remain_duration'] = Variable<int>(
        $ActiveTimersTable.$converterremainDuration.toSql(remainDuration),
      );
    }
    {
      map['set_duration'] = Variable<int>(
        $ActiveTimersTable.$convertersetDuration.toSql(setDuration),
      );
    }
    return map;
  }

  ActiveTimersCompanion toCompanion(bool nullToAbsent) {
    return ActiveTimersCompanion(
      alarmMelody: Value(alarmMelody),
      id: Value(id),
      label: Value(label),
      isRunning: Value(isRunning),
      remainDuration: Value(remainDuration),
      setDuration: Value(setDuration),
    );
  }

  factory ActiveTimer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActiveTimer(
      alarmMelody: serializer.fromJson<String>(json['alarmMelody']),
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      isRunning: serializer.fromJson<bool>(json['isRunning']),
      remainDuration: serializer.fromJson<Duration>(json['remainDuration']),
      setDuration: serializer.fromJson<Duration>(json['setDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'alarmMelody': serializer.toJson<String>(alarmMelody),
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'isRunning': serializer.toJson<bool>(isRunning),
      'remainDuration': serializer.toJson<Duration>(remainDuration),
      'setDuration': serializer.toJson<Duration>(setDuration),
    };
  }

  ActiveTimer copyWith({
    String? alarmMelody,
    String? id,
    String? label,
    bool? isRunning,
    Duration? remainDuration,
    Duration? setDuration,
  }) => ActiveTimer(
    alarmMelody: alarmMelody ?? this.alarmMelody,
    id: id ?? this.id,
    label: label ?? this.label,
    isRunning: isRunning ?? this.isRunning,
    remainDuration: remainDuration ?? this.remainDuration,
    setDuration: setDuration ?? this.setDuration,
  );
  ActiveTimer copyWithCompanion(ActiveTimersCompanion data) {
    return ActiveTimer(
      alarmMelody: data.alarmMelody.present
          ? data.alarmMelody.value
          : this.alarmMelody,
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      isRunning: data.isRunning.present ? data.isRunning.value : this.isRunning,
      remainDuration: data.remainDuration.present
          ? data.remainDuration.value
          : this.remainDuration,
      setDuration: data.setDuration.present
          ? data.setDuration.value
          : this.setDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActiveTimer(')
          ..write('alarmMelody: $alarmMelody, ')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('isRunning: $isRunning, ')
          ..write('remainDuration: $remainDuration, ')
          ..write('setDuration: $setDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    alarmMelody,
    id,
    label,
    isRunning,
    remainDuration,
    setDuration,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActiveTimer &&
          other.alarmMelody == this.alarmMelody &&
          other.id == this.id &&
          other.label == this.label &&
          other.isRunning == this.isRunning &&
          other.remainDuration == this.remainDuration &&
          other.setDuration == this.setDuration);
}

class ActiveTimersCompanion extends UpdateCompanion<ActiveTimer> {
  final Value<String> alarmMelody;
  final Value<String> id;
  final Value<String> label;
  final Value<bool> isRunning;
  final Value<Duration> remainDuration;
  final Value<Duration> setDuration;
  final Value<int> rowid;
  const ActiveTimersCompanion({
    this.alarmMelody = const Value.absent(),
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.isRunning = const Value.absent(),
    this.remainDuration = const Value.absent(),
    this.setDuration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActiveTimersCompanion.insert({
    required String alarmMelody,
    required String id,
    required String label,
    required bool isRunning,
    required Duration remainDuration,
    required Duration setDuration,
    this.rowid = const Value.absent(),
  }) : alarmMelody = Value(alarmMelody),
       id = Value(id),
       label = Value(label),
       isRunning = Value(isRunning),
       remainDuration = Value(remainDuration),
       setDuration = Value(setDuration);
  static Insertable<ActiveTimer> custom({
    Expression<String>? alarmMelody,
    Expression<String>? id,
    Expression<String>? label,
    Expression<bool>? isRunning,
    Expression<int>? remainDuration,
    Expression<int>? setDuration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (alarmMelody != null) 'alarm_melody': alarmMelody,
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (isRunning != null) 'is_running': isRunning,
      if (remainDuration != null) 'remain_duration': remainDuration,
      if (setDuration != null) 'set_duration': setDuration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActiveTimersCompanion copyWith({
    Value<String>? alarmMelody,
    Value<String>? id,
    Value<String>? label,
    Value<bool>? isRunning,
    Value<Duration>? remainDuration,
    Value<Duration>? setDuration,
    Value<int>? rowid,
  }) {
    return ActiveTimersCompanion(
      alarmMelody: alarmMelody ?? this.alarmMelody,
      id: id ?? this.id,
      label: label ?? this.label,
      isRunning: isRunning ?? this.isRunning,
      remainDuration: remainDuration ?? this.remainDuration,
      setDuration: setDuration ?? this.setDuration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (alarmMelody.present) {
      map['alarm_melody'] = Variable<String>(alarmMelody.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (isRunning.present) {
      map['is_running'] = Variable<bool>(isRunning.value);
    }
    if (remainDuration.present) {
      map['remain_duration'] = Variable<int>(
        $ActiveTimersTable.$converterremainDuration.toSql(remainDuration.value),
      );
    }
    if (setDuration.present) {
      map['set_duration'] = Variable<int>(
        $ActiveTimersTable.$convertersetDuration.toSql(setDuration.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActiveTimersCompanion(')
          ..write('alarmMelody: $alarmMelody, ')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('isRunning: $isRunning, ')
          ..write('remainDuration: $remainDuration, ')
          ..write('setDuration: $setDuration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RecentTimersTable extends RecentTimers
    with TableInfo<$RecentTimersTable, RecentTimer> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentTimersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _alarmMelodyMeta = const VerificationMeta(
    'alarmMelody',
  );
  @override
  late final GeneratedColumn<String> alarmMelody = GeneratedColumn<String>(
    'alarm_melody',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Duration, int> setDuration =
      GeneratedColumn<int>(
        'set_duration',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<Duration>($RecentTimersTable.$convertersetDuration);
  @override
  List<GeneratedColumn> get $columns => [alarmMelody, id, label, setDuration];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recent_timers';
  @override
  VerificationContext validateIntegrity(
    Insertable<RecentTimer> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('alarm_melody')) {
      context.handle(
        _alarmMelodyMeta,
        alarmMelody.isAcceptableOrUnknown(
          data['alarm_melody']!,
          _alarmMelodyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_alarmMelodyMeta);
    }
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    } else if (isInserting) {
      context.missing(_labelMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RecentTimer map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RecentTimer(
      alarmMelody: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}alarm_melody'],
      )!,
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      )!,
      setDuration: $RecentTimersTable.$convertersetDuration.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}set_duration'],
        )!,
      ),
    );
  }

  @override
  $RecentTimersTable createAlias(String alias) {
    return $RecentTimersTable(attachedDatabase, alias);
  }

  static TypeConverter<Duration, int> $convertersetDuration =
      const DurationConverter();
}

class RecentTimer extends DataClass implements Insertable<RecentTimer> {
  final String alarmMelody;
  final String id;
  final String label;
  final Duration setDuration;
  const RecentTimer({
    required this.alarmMelody,
    required this.id,
    required this.label,
    required this.setDuration,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['alarm_melody'] = Variable<String>(alarmMelody);
    map['id'] = Variable<String>(id);
    map['label'] = Variable<String>(label);
    {
      map['set_duration'] = Variable<int>(
        $RecentTimersTable.$convertersetDuration.toSql(setDuration),
      );
    }
    return map;
  }

  RecentTimersCompanion toCompanion(bool nullToAbsent) {
    return RecentTimersCompanion(
      alarmMelody: Value(alarmMelody),
      id: Value(id),
      label: Value(label),
      setDuration: Value(setDuration),
    );
  }

  factory RecentTimer.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RecentTimer(
      alarmMelody: serializer.fromJson<String>(json['alarmMelody']),
      id: serializer.fromJson<String>(json['id']),
      label: serializer.fromJson<String>(json['label']),
      setDuration: serializer.fromJson<Duration>(json['setDuration']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'alarmMelody': serializer.toJson<String>(alarmMelody),
      'id': serializer.toJson<String>(id),
      'label': serializer.toJson<String>(label),
      'setDuration': serializer.toJson<Duration>(setDuration),
    };
  }

  RecentTimer copyWith({
    String? alarmMelody,
    String? id,
    String? label,
    Duration? setDuration,
  }) => RecentTimer(
    alarmMelody: alarmMelody ?? this.alarmMelody,
    id: id ?? this.id,
    label: label ?? this.label,
    setDuration: setDuration ?? this.setDuration,
  );
  RecentTimer copyWithCompanion(RecentTimersCompanion data) {
    return RecentTimer(
      alarmMelody: data.alarmMelody.present
          ? data.alarmMelody.value
          : this.alarmMelody,
      id: data.id.present ? data.id.value : this.id,
      label: data.label.present ? data.label.value : this.label,
      setDuration: data.setDuration.present
          ? data.setDuration.value
          : this.setDuration,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RecentTimer(')
          ..write('alarmMelody: $alarmMelody, ')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('setDuration: $setDuration')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(alarmMelody, id, label, setDuration);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RecentTimer &&
          other.alarmMelody == this.alarmMelody &&
          other.id == this.id &&
          other.label == this.label &&
          other.setDuration == this.setDuration);
}

class RecentTimersCompanion extends UpdateCompanion<RecentTimer> {
  final Value<String> alarmMelody;
  final Value<String> id;
  final Value<String> label;
  final Value<Duration> setDuration;
  final Value<int> rowid;
  const RecentTimersCompanion({
    this.alarmMelody = const Value.absent(),
    this.id = const Value.absent(),
    this.label = const Value.absent(),
    this.setDuration = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RecentTimersCompanion.insert({
    required String alarmMelody,
    required String id,
    required String label,
    required Duration setDuration,
    this.rowid = const Value.absent(),
  }) : alarmMelody = Value(alarmMelody),
       id = Value(id),
       label = Value(label),
       setDuration = Value(setDuration);
  static Insertable<RecentTimer> custom({
    Expression<String>? alarmMelody,
    Expression<String>? id,
    Expression<String>? label,
    Expression<int>? setDuration,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (alarmMelody != null) 'alarm_melody': alarmMelody,
      if (id != null) 'id': id,
      if (label != null) 'label': label,
      if (setDuration != null) 'set_duration': setDuration,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RecentTimersCompanion copyWith({
    Value<String>? alarmMelody,
    Value<String>? id,
    Value<String>? label,
    Value<Duration>? setDuration,
    Value<int>? rowid,
  }) {
    return RecentTimersCompanion(
      alarmMelody: alarmMelody ?? this.alarmMelody,
      id: id ?? this.id,
      label: label ?? this.label,
      setDuration: setDuration ?? this.setDuration,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (alarmMelody.present) {
      map['alarm_melody'] = Variable<String>(alarmMelody.value);
    }
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (setDuration.present) {
      map['set_duration'] = Variable<int>(
        $RecentTimersTable.$convertersetDuration.toSql(setDuration.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentTimersCompanion(')
          ..write('alarmMelody: $alarmMelody, ')
          ..write('id: $id, ')
          ..write('label: $label, ')
          ..write('setDuration: $setDuration, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ActiveTimersTable activeTimers = $ActiveTimersTable(this);
  late final $RecentTimersTable recentTimers = $RecentTimersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    activeTimers,
    recentTimers,
  ];
}

typedef $$ActiveTimersTableCreateCompanionBuilder =
    ActiveTimersCompanion Function({
      required String alarmMelody,
      required String id,
      required String label,
      required bool isRunning,
      required Duration remainDuration,
      required Duration setDuration,
      Value<int> rowid,
    });
typedef $$ActiveTimersTableUpdateCompanionBuilder =
    ActiveTimersCompanion Function({
      Value<String> alarmMelody,
      Value<String> id,
      Value<String> label,
      Value<bool> isRunning,
      Value<Duration> remainDuration,
      Value<Duration> setDuration,
      Value<int> rowid,
    });

class $$ActiveTimersTableFilterComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isRunning => $composableBuilder(
    column: $table.isRunning,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Duration, Duration, int> get remainDuration =>
      $composableBuilder(
        column: $table.remainDuration,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Duration, Duration, int> get setDuration =>
      $composableBuilder(
        column: $table.setDuration,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$ActiveTimersTableOrderingComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isRunning => $composableBuilder(
    column: $table.isRunning,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get remainDuration => $composableBuilder(
    column: $table.remainDuration,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setDuration => $composableBuilder(
    column: $table.setDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActiveTimersTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActiveTimersTable> {
  $$ActiveTimersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<bool> get isRunning =>
      $composableBuilder(column: $table.isRunning, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Duration, int> get remainDuration =>
      $composableBuilder(
        column: $table.remainDuration,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<Duration, int> get setDuration =>
      $composableBuilder(
        column: $table.setDuration,
        builder: (column) => column,
      );
}

class $$ActiveTimersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActiveTimersTable,
          ActiveTimer,
          $$ActiveTimersTableFilterComposer,
          $$ActiveTimersTableOrderingComposer,
          $$ActiveTimersTableAnnotationComposer,
          $$ActiveTimersTableCreateCompanionBuilder,
          $$ActiveTimersTableUpdateCompanionBuilder,
          (
            ActiveTimer,
            BaseReferences<_$AppDatabase, $ActiveTimersTable, ActiveTimer>,
          ),
          ActiveTimer,
          PrefetchHooks Function()
        > {
  $$ActiveTimersTableTableManager(_$AppDatabase db, $ActiveTimersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActiveTimersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActiveTimersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActiveTimersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> alarmMelody = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<bool> isRunning = const Value.absent(),
                Value<Duration> remainDuration = const Value.absent(),
                Value<Duration> setDuration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActiveTimersCompanion(
                alarmMelody: alarmMelody,
                id: id,
                label: label,
                isRunning: isRunning,
                remainDuration: remainDuration,
                setDuration: setDuration,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String alarmMelody,
                required String id,
                required String label,
                required bool isRunning,
                required Duration remainDuration,
                required Duration setDuration,
                Value<int> rowid = const Value.absent(),
              }) => ActiveTimersCompanion.insert(
                alarmMelody: alarmMelody,
                id: id,
                label: label,
                isRunning: isRunning,
                remainDuration: remainDuration,
                setDuration: setDuration,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActiveTimersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActiveTimersTable,
      ActiveTimer,
      $$ActiveTimersTableFilterComposer,
      $$ActiveTimersTableOrderingComposer,
      $$ActiveTimersTableAnnotationComposer,
      $$ActiveTimersTableCreateCompanionBuilder,
      $$ActiveTimersTableUpdateCompanionBuilder,
      (
        ActiveTimer,
        BaseReferences<_$AppDatabase, $ActiveTimersTable, ActiveTimer>,
      ),
      ActiveTimer,
      PrefetchHooks Function()
    >;
typedef $$RecentTimersTableCreateCompanionBuilder =
    RecentTimersCompanion Function({
      required String alarmMelody,
      required String id,
      required String label,
      required Duration setDuration,
      Value<int> rowid,
    });
typedef $$RecentTimersTableUpdateCompanionBuilder =
    RecentTimersCompanion Function({
      Value<String> alarmMelody,
      Value<String> id,
      Value<String> label,
      Value<Duration> setDuration,
      Value<int> rowid,
    });

class $$RecentTimersTableFilterComposer
    extends Composer<_$AppDatabase, $RecentTimersTable> {
  $$RecentTimersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Duration, Duration, int> get setDuration =>
      $composableBuilder(
        column: $table.setDuration,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );
}

class $$RecentTimersTableOrderingComposer
    extends Composer<_$AppDatabase, $RecentTimersTable> {
  $$RecentTimersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get setDuration => $composableBuilder(
    column: $table.setDuration,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RecentTimersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RecentTimersTable> {
  $$RecentTimersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get alarmMelody => $composableBuilder(
    column: $table.alarmMelody,
    builder: (column) => column,
  );

  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Duration, int> get setDuration =>
      $composableBuilder(
        column: $table.setDuration,
        builder: (column) => column,
      );
}

class $$RecentTimersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RecentTimersTable,
          RecentTimer,
          $$RecentTimersTableFilterComposer,
          $$RecentTimersTableOrderingComposer,
          $$RecentTimersTableAnnotationComposer,
          $$RecentTimersTableCreateCompanionBuilder,
          $$RecentTimersTableUpdateCompanionBuilder,
          (
            RecentTimer,
            BaseReferences<_$AppDatabase, $RecentTimersTable, RecentTimer>,
          ),
          RecentTimer,
          PrefetchHooks Function()
        > {
  $$RecentTimersTableTableManager(_$AppDatabase db, $RecentTimersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RecentTimersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RecentTimersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RecentTimersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> alarmMelody = const Value.absent(),
                Value<String> id = const Value.absent(),
                Value<String> label = const Value.absent(),
                Value<Duration> setDuration = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RecentTimersCompanion(
                alarmMelody: alarmMelody,
                id: id,
                label: label,
                setDuration: setDuration,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String alarmMelody,
                required String id,
                required String label,
                required Duration setDuration,
                Value<int> rowid = const Value.absent(),
              }) => RecentTimersCompanion.insert(
                alarmMelody: alarmMelody,
                id: id,
                label: label,
                setDuration: setDuration,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$RecentTimersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RecentTimersTable,
      RecentTimer,
      $$RecentTimersTableFilterComposer,
      $$RecentTimersTableOrderingComposer,
      $$RecentTimersTableAnnotationComposer,
      $$RecentTimersTableCreateCompanionBuilder,
      $$RecentTimersTableUpdateCompanionBuilder,
      (
        RecentTimer,
        BaseReferences<_$AppDatabase, $RecentTimersTable, RecentTimer>,
      ),
      RecentTimer,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ActiveTimersTableTableManager get activeTimers =>
      $$ActiveTimersTableTableManager(_db, _db.activeTimers);
  $$RecentTimersTableTableManager get recentTimers =>
      $$RecentTimersTableTableManager(_db, _db.recentTimers);
}
