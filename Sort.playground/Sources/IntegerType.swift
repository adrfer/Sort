import Foundation

public extension Int {

    // MARK: - Type Methods

    /// Generate a uniformly distributed random integer
    ///
    /// - parameters:
    ///
    ///   - min: Inclusive lower bound random value
    ///   - max: Inclusive upper bound random value
    ///
    /// - returns: A random integer between min and max

    static func random(min min: Int = 0, max: Int) -> Int {
        return min + Int(arc4random_uniform(UInt32(max - min + 1)))
    }
}