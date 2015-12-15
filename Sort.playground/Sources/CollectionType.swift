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

public extension MutableCollectionType where Index == Int {

    // MARK: - Instance Methods

    /// Shuffle the elements of `self` in-place using Fisher-Yeates algorithm

    mutating func shuffleInPlace() {

        guard count > 1 else {
            return
        }

        for i in 0..<count - 1 {
            // let j = i + Int(arc4random_uniform(UInt32(count - i)))
            let j = Int.random(min: i, max: self.count - 1)

            guard i != j else {
                continue
            }

            (self[i], self[j]) = (self[j], self[i])
        }
    }

    /// Choose a random element from self
    ///
    /// - returns: An optional random element from `self` or `nil` if `self` is empty

    func sample() -> Generator.Element? {

        guard !isEmpty else {
            return nil
        }

        let index = Int.random(max: self.count - 1)
        return self[index]
    }
}