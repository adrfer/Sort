import Foundation

public extension CollectionType {

    // MARK: - Instance Methods

    /// Shuffle elements of `self`
    ///
    /// - Returns: A copy of `self` with its elements shuffled

    @warn_unused_result(mutable_variant="shuffleInPlace")
    func shuffle() -> [Generator.Element] {
        var array = Array(self)
        array.shuffleInPlace()
        return array
    }
}

public extension CollectionType where Index.Distance == Int {

    // MARK: - Instance Methods

    /// Choose a random element from `self`
    ///
    /// - Returns: An optional random element from `self`, or `nil` if `self` is empty

    @warn_unused_result
    func sample() -> Generator.Element? {
        guard !isEmpty else {
            return nil
        }

        let offset = Int.random(from: 0, to: count - 1)
        let index = startIndex.advancedBy(offset)

        return self[index]
    }
}