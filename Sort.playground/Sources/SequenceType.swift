import Foundation

/// Describe the possible ways to order a sequence

public enum Order {
    case Ascending
    case Descending
}

public extension SequenceType {
    
    /// Check if sequence is sorted based on a comparison closure
    ///
    /// - Parameter isOrderedBefore: A closure that takes in the two elements to be compares,
    ///             and returns true if the first is orderd before the second, false otherwise
    ///
    /// - Returns: True if sequence is sorted, false otherwise
    
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

    /// Check if sequence is sorted based on a given ordering
    ///
    /// - Parameter order: The order the sequence should be sorted
    ///
    /// - Returns: True if sequence is sorted, false otherwise
    ///
    /// - Remark: The `<=` and `>=` predicates account for reapeated values

    func isSorted(order: Order = .Ascending) -> Bool {
        return order == .Ascending ? isSorted(<=) : isSorted(>=)
    }
}