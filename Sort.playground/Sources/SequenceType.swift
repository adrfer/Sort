import Foundation

public extension SequenceType {
    
    /// Checks if sequence is sorted based on a comparison closure
    ///
    /// - parameter isOrderedBefore: A closure that takes in the two elements to be compares,
    ///             and returns true if the first is orderd before the second, false otherwise
    ///
    /// - returns: True if sequence is sorted, false otherwise
    
    func isSorted(@noescape isOrderedBefore: (Generator.Element, Generator.Element) -> Bool) -> Bool {
        
        var previous: Generator.Element?
        
        for element in self {
            
            if let previous = previous where !isOrderedBefore(previous, element) {
                return false
            }
            
            previous = element
        }
        
        return true
    }
}

public extension SequenceType where Generator.Element: Comparable {
    
    /// Checks if sequence is sorted in ascending order
    ///
    /// - returns: True if sequence is sorted, false otherwise
    
    func isSorted() -> Bool {
        
        return isSorted(<=)
    }
}