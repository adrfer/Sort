import Foundation

public extension Collection {

    // MARK: - Instance Methods

    /// Shuffle elements of `self`
    ///
    /// - Returns: A copy of `self` with its elements shuffled

    func shuffled() -> [Iterator.Element] {

        var array = Array(self)
        array.shuffle()

        return array
    }
}

public extension Collection where IndexDistance == Int {

    // MARK: - Instance Methods

    /// Choose a random element from `self`
    ///
    /// - Returns: An optional random element from `self`, or `nil` if `self` is empty

    func sampled() -> Iterator.Element? {

        guard !isEmpty else {
            return nil
        }

        let offset = Int.random(from: 0, to: count - 1)

        return self[index(startIndex, offsetBy: offset)]
    }
}
