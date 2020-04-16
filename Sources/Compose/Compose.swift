import Foundation

@dynamicMemberLookup
public struct Compose<Element1, Element2> {
    public var element1: Element1
    public var element2: Element2

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Element1, T>) -> T {
        get { element1[keyPath: keyPath] }
        set { element1[keyPath: keyPath] = newValue }
    }

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Element2, T>) -> T {
        get { element2[keyPath: keyPath] }
        set { element2[keyPath: keyPath] = newValue }
    }

    public init(_ element1: Element1, _ element2: Element2) {
        self.element1 = element1
        self.element2 = element2
    }
}

// MARK - Conformances

extension Compose: Encodable where Element1: Encodable, Element2: Encodable {
    public func encode(to encoder: Encoder) throws {
        try element1.encode(to: encoder)
        try element2.encode(to: encoder)
    }
}

extension Compose: Decodable where Element1: Decodable, Element2: Decodable {
    public init(from decoder: Decoder) throws {
        self.element1 = try Element1(from: decoder)
        self.element2 = try Element2(from: decoder)
    }
}

extension Compose: Equatable where Element1: Equatable, Element2: Equatable { }

extension Compose: Hashable where Element1: Hashable, Element2: Hashable { }

extension Compose: Error where Element1: Error, Element2: Error { }

extension Compose: LocalizedError where Element1: LocalizedError, Element2: LocalizedError {
    public var errorDescription: String? {
        [element1.errorDescription, element2.errorDescription].filterAndJoin()
    }
    public var failureReason: String? {
        [element1.failureReason, element2.failureReason].filterAndJoin()
    }
    public var recoverySuggestion: String? {
        [element1.recoverySuggestion, element2.recoverySuggestion].filterAndJoin()
    }
    public var helpAnchor: String? {
        [element1.helpAnchor, element2.helpAnchor].filterAndJoin()
    }
}

private extension Array where Element == String? {
    func filterAndJoin() -> String {
        return compactMap { $0 }.joined(separator: "\n")
    }
}

// MARK - typealiases for composition with multiple types

public typealias Compose3<T1, T2, T3> =
    Compose<T1, Compose<T2, T3>>

public typealias Compose4<T1, T2, T3, T4> =
    Compose<Compose<T1, T2>, Compose<T3, T4>>

public typealias Compose5<T1, T2, T3, T4, T5> =
    Compose<Compose<T1, T2>, Compose<T3, Compose<T4, T5>>>
