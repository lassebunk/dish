# Changelog

## 0.0.6

* `Dish::Plate#==` now compares with the original hash, or anything that responds to `to_h`.
* `Dish::Plate#hash` is taken from the original hash. This enables using `group_by` and `uniq`.

## 0.0.5

* Supports setting values via `some_dish_object.key = 'value'`.
* Values are now cached after their first conversion. This improves performance when calling the same methods repeatedly.
* Available keys are returned by the `methods` method on a Dish object.
* `as_hash` is deprecated and renamed to `to_h`.
* Supports converting the Dish object to json via `to_json`.
* `respond_to?` and `respond_to_missing?` now works correctly.

## 0.0.4

* Implements `respond_to_missing?`.

## 0.0.3

* Adds coercion. See the readme for details.
* Adds an `as_hash` method for accessing the original source hash.