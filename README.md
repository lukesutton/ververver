# VerVerVer

A library for defining versions, version requirements and making comparisons between them.

It's useful for asking the following:

* Checking if versions greater, lesser or equal to one another
* Defining version requirements with semantics like matching, less than, greater than etc
* Comparing requirements to see if matching versions from one could _potentially_ satisfy another

One other notable feature is that it uses generics and protocols to allow support for any orderable version scheme. It has semantic versioning built in, but can be extended to handle different schemes.

## Please Note

* I'm learning Swift and may be doing something daft
* Not ready for production use

## Versions

Here is an example of instantiating the built-in semantic version:

```swift
let version = SemanticVersion(1, 0, 0)
```

You can compare versions:

```swift
let one = SemanticVersion(1, 0, 0)
let two = SemanticVersion(2, 0, 0)

one == two // false
one > two // false
one < two // true
```

Pretty simple really. Versions don't need to do more than be comparable and orderable.

## Version Requirements

These are a mechanism of expressing requirements and then seeing if versions satisfy the requirements.

Here is a simple example:

```swift
let req = VersionRequirement<SemanticVersion>.equal(SemanticVersion(1))
let version = SemanticVersion(2)
req.versionSatisfies(version) // false
```

The requirement has the type `VersionRequirement<V: VersionType>`, which is the primary mechanism for supporting multiple version types.

Requirements can also be compared. The following answers a simple question; "can a potential matching version in one requirement satisfy another?"

```swift
let first = VersionRequirement<SemanticVersion>.lessThan(SemanticVersion(2))
let second = VersionRequirement<SemanticVersion>.lessThan(SemanticVersion(1))

first.versionsCouldSatisfy(second) // true
```

## Adding Version Schemes

Define a struct that conforms to the `VersionType` protocol. This implies conformance with the `comparable`, `orderable` and `hashable` protocols.

Satisfying the protocols requires implementation of:

* `==` operator
* `<` operator
* `hashValue` property

## Todos

* [ ] Investigate diffing versions e.g. are they close, is one greater than the other?
* [ ] Expand built in version types
