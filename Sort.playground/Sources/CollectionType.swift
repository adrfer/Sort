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