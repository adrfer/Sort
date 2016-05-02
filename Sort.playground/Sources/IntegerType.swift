import Foundation

public extension IntegerType {

    // MARK: - Type Methods

    /// Generate a uniformly distributed random integer
    ///
    /// - Parameters:
    ///
    ///   - lower: Inclusive lower bound random value
    ///   - upper: Inclusive upper bound random value
    ///
    /// - Returns: A random integer between `lower` and `upper` bounds

    static func random(from lower: Int, to upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}