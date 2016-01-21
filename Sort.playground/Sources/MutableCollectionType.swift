import Foundation

public extension MutableCollectionType where Index == Int {

    // MARK: - Instance Methods

    /// Shuffle the elements of `self` in-place using Fisher-Yeates algorithm

    mutating func shuffleInPlace() {

        guard count > 1 else {
            return
        }

        for i in 0..<count - 1 {

            let j = Int.random(min: i, max: count - 1)

            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }

    /// Choose a random element from self
    ///
    /// - returns: An optional random element from `self` or `nil` if `self` is empty

    func pick() -> Generator.Element? {

        guard !isEmpty else {
            return nil
        }

        let index = Int.random(max: count - 1)
        
        return self[index]
    }
}