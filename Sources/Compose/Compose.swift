import Foundation

@dynamicMemberLookup
public struct Compose<Element1, Element2> {
    /// The first element of the composition. In most cases you should not use this property, and
    /// instead, in order to access the child properties you better use the dynamicMember subscript
    public var _element1: Element1
    /// The second element of the composition. In most cases you should not use this property, and
    /// instead, in order to access the child properties you better use the dynamicMember subscript
    public var _element2: Element2

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Element1, T>) -> T {
        get { _element1[keyPath: keyPath] }
        set { _element1[keyPath: keyPath] = newValue }
    }

    public subscript<T>(dynamicMember keyPath: WritableKeyPath<Element2, T>) -> T {
        get { _element2[keyPath: keyPath] }
        set { _element2[keyPath: keyPath] = newValue }
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Element1, T>) -> T {
        _element1[keyPath: keyPath]
    }

    public subscript<T>(dynamicMember keyPath: KeyPath<Element2, T>) -> T {
        _element2[keyPath: keyPath]
    }

    public init(_ _element1: Element1, _ _element2: Element2) {
        self._element1 = _element1
        self._element2 = _element2
    }
}

// MARK - Conformances

extension Compose: Encodable where Element1: Encodable, Element2: Encodable {
    public func encode(to encoder: Encoder) throws {
        // Here, if element1 has any property with the same name as element2, element1 property will prevail
        // because it will override the property from element2
        try _element2.encode(to: encoder)
        try _element1.encode(to: encoder)
    }
}

extension Compose: Decodable where Element1: Decodable, Element2: Decodable {
    public init(from decoder: Decoder) throws {
        self._element1 = try Element1(from: decoder)
        self._element2 = try Element2(from: decoder)
    }
}

extension Compose: Equatable where Element1: Equatable, Element2: Equatable { }

extension Compose: Hashable where Element1: Hashable, Element2: Hashable { }

extension Compose: Error where Element1: Error, Element2: Error { }

extension Compose: LocalizedError where Element1: LocalizedError, Element2: LocalizedError {
    public var errorDescription: String? {
        [_element1.errorDescription, _element2.errorDescription].filterAndJoin()
    }
    public var failureReason: String? {
        [_element1.failureReason, _element2.failureReason].filterAndJoin()
    }
    public var recoverySuggestion: String? {
        [_element1.recoverySuggestion, _element2.recoverySuggestion].filterAndJoin()
    }
    public var helpAnchor: String? {
        [_element1.helpAnchor, _element2.helpAnchor].filterAndJoin()
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
