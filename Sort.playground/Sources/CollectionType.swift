import Foundation

public extension CollectionType {

    // MARK: - Instance Methods

    /// Shuffle the elements of `self`
    ///
    /// - returns: A copy of `self` with its elements shuffled

    func shuffle() -> [Generator.Element] {
        var array = Array(self)
        array.shuffleInPlace()
        return array
    }
}