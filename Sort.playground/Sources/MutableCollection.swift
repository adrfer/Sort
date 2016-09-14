import Foundation

public extension MutableCollection where Index == Int, IndexDistance == Int {

    // MARK: - Instance Methods

    /// Shuffle elements of `self` in place
    ///
    /// - Note: This implementation uses the Fisher–Yates algorithm

    mutating func shuffle() {

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
}
