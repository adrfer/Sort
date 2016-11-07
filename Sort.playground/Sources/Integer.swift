import Foundation

public extension Integer {

    // MARK: - Type Methods

    /// Generate a uniformly distributed random integer
    ///
    /// - Parameters:
    ///
    ///   - lowerBound: Inclusive lower bound value
    ///   - upperBound: Inclusive upper bound value
    ///
    /// - Returns: A random integer between `lowerBound` and `upperBound` values

    static func random(from lowerBound: Int, to upperBound: Int) -> Int {
        
        return lowerBound + Int(arc4random_uniform(UInt32(upperBound - lowerBound + 1)))
    }
}
