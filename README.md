# Compose

[![CI](https://github.com/acecilia/Compose/workflows/CI/badge.svg?branch=master)](https://github.com/acecilia/Compose/actions)
[![CI](https://codecov.io/gh/acecilia/Compose/branch/master/graph/badge.svg)](https://codecov.io/github/acecilia/Compose)

## What is this?

A Swift library for composing structs from other structs, which relies on the `KeyPath` and `@dynamicMemberLookup` features to provide a clean and typesafe API:

```swift
import Compose

struct Developer: Codable, Hashable {
    var name: String
    var age: Int
}

struct RemoteLocation: Codable, Hashable {
    var country: String
    var city: String
}

typealias RemoteDeveloper = Compose<Developer, RemoteLocation>

let remoteDeveloper = RemoteDeveloper(
    .init(name: "Andres", age: 26), 
    .init(country: "Spain", city: "Madrid")
)
print(remoteDeveloper.name) // Andres
print(remoteDeveloper.city) // Madrid
```

For an in depth explanation please [follow this link](https://www.sforswift.com/posts/composition-using-keypath-and-dynamic-member-lookup/).

## Installation

### Swift Package Manager

Add the following to the dependencies inside your `Package.swift` file:

```swift
.package(url: "https://github.com/acecilia/Compose.git", .upToNextMajor(from: "0.0.1")),
```

## License

Compose is licensed under the MIT license. See [LICENSE](LICENSE) for more info.
