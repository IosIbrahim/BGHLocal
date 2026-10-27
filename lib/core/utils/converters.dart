
// Defensive JSON value converters for use as `@JsonKey(fromJson: ...)` hooks.
// The backend may return numeric fields as strings ("82"), sometimes decimals
// ("82.0"), and values may be null/missing.
int asInt(dynamic value) =>
    num.tryParse(value?.toString().trim() ?? '')?.toInt() ?? 0;

/// Parses a decimal that may arrive as a string ("31865.74"), a number, or null.
double asDouble(dynamic value) =>
    double.tryParse(value?.toString().trim() ?? '') ?? 0;

String asStr(dynamic value) => value?.toString() ?? '';

/// Stringifies an identifier that may arrive as a number (`3.0` -> "3"), a
/// string ("3" -> "3"), or null (-> ""). Avoids the ugly ".0" suffix that a
/// plain `toString()` would leave on integral doubles.
String asIdStr(dynamic value) {
  if (value == null) return '';
  final n = num.tryParse(value.toString().trim());
  if (n != null && n.isFinite && n == n.truncate()) return n.toInt().toString();
  return value.toString();
}

// ---------------------------------------------------------------------------
// SAP-style envelope unwrapping.
//
// The backend wraps payloads in single-key container objects, e.g.
//   { "OUT_PARMS": { "OUT_PARMS_ROW": { ...fields } } }   // object
//   { "INF_BOD_AREA": { "INF_BOD_AREA_ROW": [ {...}, {...} ] } }   // array
// and a list with exactly one element is collapsed into a bare object:
//   { "OUT_PARMS": { "OUT_PARMS_ROW": { ...single row } } }   // 1-item list
//
// These are the Dart equivalents of the Android Gson `ObjectDeSerializer` /
// `ArrayDeSerializer`. They are plain functions so they compose both as
// `@JsonKey(fromJson: ...)` hooks on a nested field and as a one-liner inside a
// `fromJson` factory when the whole HTTP body is the envelope.
// ---------------------------------------------------------------------------

/// Walks through single-key wrapper objects (`X` -> `X_ROW` -> ...) until the
/// node is no longer a single-key map whose value is itself a map/list. Stops
/// at arrays, at multi-field maps, and at single-field maps whose value is a
/// scalar (that map IS the payload, e.g. `{ "TOTAL": "118" }`).
dynamic _unwrapEnvelope(dynamic node) {
  var current = node;
  while (current is Map<String, dynamic> && current.length == 1) {
    final child = current.values.first;
    if (child is Map<String, dynamic> || child is List) {
      current = child;
    } else {
      break;
    }
  }
  return current;
}

/// Unwraps an envelope down to a single object. If the payload is an array
/// (e.g. a 1-element list that was *not* collapsed), the first map is returned.
/// Returns an empty map when there is nothing usable so a `fromJson` factory
/// can still run against defensive `asInt`/`asStr` hooks.
Map<String, dynamic> unwrapObject(dynamic node) {
  final payload = _unwrapEnvelope(node);
  if (payload is Map<String, dynamic>) return payload;
  if (payload is List) {
    for (final e in payload) {
      if (e is Map<String, dynamic>) return e;
    }
  }
  return <String, dynamic>{};
}

/// Unwraps an envelope into a list of objects. An array becomes a list of maps;
/// a single collapsed object becomes a one-element list; null/empty becomes
/// `[]`. Mirrors the Android `ArrayDeSerializer`.
List<Map<String, dynamic>> unwrapList(dynamic node) {
  final payload = _unwrapEnvelope(node);
  if (payload is List) {
    return payload.whereType<Map<String, dynamic>>().toList();
  }
  if (payload is Map<String, dynamic> && payload.isNotEmpty) {
    return [payload];
  }
  return const [];
}
