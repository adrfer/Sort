import Foundation

public extension CollectionType {

    /// Shuffles the elements of `self`
    ///
    /// - returns: A copy of `self` with its elements shuffled

    func shuffle() -> [Generator.Element] {
        var array = Array(self)
        array.shuffleInPlace()
        return array
    }
}

public extension MutableCollectionType where Index == Int {

    /// Shuffles the elements of `self` in-place using Fisher-Yeates algorithm

    mutating func shuffleInPlace() {

        guard count > 1 else {
            return
        }

        for i in 0..<count - 1 {
            let j = i + Int(arc4random_uniform(UInt32(count - i)))

            guard i != j else {
                continue
            }

            swap(&self[i], &self[j])
        }
    }
}