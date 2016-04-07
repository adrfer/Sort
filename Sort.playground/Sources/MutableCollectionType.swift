import Foundation

public extension MutableCollectionType where Index == Int {

    // MARK: - Instance Methods

    /// Shuffle elements of `self` in place
    ///
    /// - Note: This implementation uses the Fisher–Yates algorithm

    mutating func shuffleInPlace() {
        guard count > 1 else {
            return
        }

        for i in 0..<count - 1 {
            let j = Int.random(from: i, to: count - 1)

            if i != j {
                swap(&self[i], &self[j])
            }
        }
    }

    /// Choose a random element from self
    ///
    /// - Returns: An optional random element from `self`, or `nil` if it is empty

    func pick() -> Generator.Element? {
        guard !isEmpty else {
            return nil
        }

        let index = Int.random(from: 0, to: count - 1)
        return self[index]
    }
}