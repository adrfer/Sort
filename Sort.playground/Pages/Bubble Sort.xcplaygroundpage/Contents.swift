//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Bubble Sort
//: ----
//:
//: ### About
//: Bubble Sort, a.k.a. Sinking Sort, is a sorting algorithm that repeatedly steps through an array to be sorted, compares each pair of adjacent elements and swaps them if they are in the wrong order. The pass through the array is repeated until swaps are no longer needed, meaning the array is then sorted. Interestingly, this algorithm gets its name from the way elements eventually _bubble up_ to their proper position, untimately rendering the array sorted.
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    if array is empty or constains 1 element, it's then already sorted, so return it
//:
//:    repeat
//:
//:      for i = 0 to n - 1
//:
//:        if array[i] > array[i + 1]
//:
//:          swap array[i] and array[i + 1]
//:
//:          mark that a swap ocurred
//:
//:    until no more swaps
//:
//:    return sorted array
//:
//:
//: ### Optimizations
//:
//: - First, the number of passes through the array is equal the number of its elements minus one.
//: - Second, at each pass we keep track of whether or not an element was swapped. If not, it's safe to assume the array is sorted.
//: - Finally, at the end of the i-th pass, the last i elements are already sorted, so there's no need to consider them on subsequent passes.
//:
//:
//: ### Properties
//:
//: - Worst case runtime is of complexity _O(n²)_
//: - Best case runtime is of complexity _Ω(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory,
/// using traditional `for`, early exit with `if`, and manual swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theClassic(var array: [Int]) -> [Int] {
    
    if array.count <= 1 {
        return array
    }
    
    for var i = 0; i < array.count - 1; ++i {
        
        var swapped = false

        for var j = 0; j < array.count - i - 1; ++j {
            
            if array[j] > array[j + 1] {
                
                let temporary = array[j]
                array[j] = array[j + 1]
                array[j + 1] = temporary
                
                swapped = true
            }
        }
        
        if !swapped {
            break
        }
    }
    
    return array
}

// Already Sorted
assert(bubbleSort_theClassic([Int]()).isSorted())
assert(bubbleSort_theClassic([7]).isSorted())
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A nifty take on the classic, but strives to use more modern
/// laguage constructs, now using `guard`, `for-in`, and `swap`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theSwiftish(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    for i in 0..<array.count - 1 {
        
        var swapped = false
        
        for j in 0..<array.count - i - 1 {
            
            if array[j] > array[j + 1] {
                
                swap(&array[j], &array[j + 1])
                swapped = true
            }
        }
        
        guard swapped else {
            break
        }
        
    }
    
    return array
}

// Already Sorted
assert(bubbleSort_theSwiftish([Int]()).isSorted())
assert(bubbleSort_theSwiftish([7]).isSorted())
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A highly creative approach that attempts to tap into the most powerful
/// features yet, now using `guard`, `for-in-where`, `repeat-while`, and
/// tuple swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theSwiftest(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    var swapped: Bool
    var endIndex = array.count
    
    repeat {
        
        swapped = false
        
        for i in 0..<endIndex - 1 where array[i] > array[i + 1] {
            
            (array[i], array[i + 1]) = (array[i + 1], array[i])
            swapped = true
        }
        
        --endIndex
        
    } while swapped
    
    return array
}

// Already Sorted
assert(bubbleSort_theSwiftest([Int]()).isSorted())
assert(bubbleSort_theSwiftest([7]).isSorted())
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(bubbleSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())

/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status,
/// now using `guard`, `for-in-where`, `repeat-while`, tuple swapping, and Generics
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func bubbleSort_theGeneric<T: Comparable>(var array: [T]) -> [T] {
    
    guard array.count > 1 else {
        return array
    }
    
    var swapped: Bool
    var endIndex = array.count
    
    repeat {
        
        swapped = false
        
        for i in 0..<endIndex - 1 where array[i] > array[i + 1] {
            
            (array[i], array[i + 1]) = (array[i + 1], array[i])
            swapped = true
        }
        
        --endIndex
        
    } while swapped
    
    return array
}

// Already Sorted

assert(bubbleSort_theGeneric([Int]()).isSorted())
assert(bubbleSort_theGeneric([7]).isSorted())
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(bubbleSort_theGeneric([String]()).isSorted())
assert(bubbleSort_theGeneric(["a"]).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(bubbleSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(bubbleSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Shuffled
assert(bubbleSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(bubbleSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)