import Foundation

public enum Order {
    case Ascending
    case Descending
}

public extension SequenceType {
    
    /// Check if sequence is sorted based on a comparison closure
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
    
    /// Check by default if sequence is sorted in ascending order
    ///
    /// - remark: The `<=` predicate accounts for reapeated values
    ///
    /// - note: To check if sequence is sorted in descending order use `isSorted(>=)` instead
    ///
    /// - returns: True if sequence is sorted, false otherwise
    
    func isSorted() -> Bool {
        
        return isSorted(<=)
    }

    /// Check if sequence is sorted based on a given ordering
    ///
    /// - parameter order: The order the sequence should be sorted
    ///
    /// - returns: True if sequence is sorted, false otherwise

    func isSorted(order: Order) -> Bool {

        return order == .Ascending ? isSorted(<=) : isSorted(>=)
    }
}