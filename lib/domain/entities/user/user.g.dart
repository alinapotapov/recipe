// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      name: json['name'] as String,
      surname: json['surname'] as String,
      age: (json['age'] as num).toInt(),
      country: json['country'] as String,
      number: (json['number'] as num).toInt(),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'age': instance.age,
      'country': instance.country,
      'number': instance.number,
    };
