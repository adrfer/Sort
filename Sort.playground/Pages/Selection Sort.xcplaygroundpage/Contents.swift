//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Selection Sort
//: ----
//:
//: ### About
//: The basic idea behind it is to divide the array into two portions, the sorted portion and the unsorted portion. At the beginning, the sorted portion is empty, while the unsorted one contains all the values. At every step, the algorithm finds the minimum element in the unsorted portion and moves it to the end of the sorted portion of the array. Eventually, the unsorted portion becomes empty and the entire array is sorted in ascending order.
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    if n <= 1, array is already sorted, so return it
//:
//:    for i = 1 to n - 1
//:      consider the min = i
//:
//:      for j = i + 1 to n
//:        if array[j] < array[min]
//:          update the min = j
//:
//:      if i ! min
//:        swap array[i] and array[min]
//:
//:    return sorted array
//:
//: ### Properties
//:
//: - Worst case runtime is of complexity _O(n²)_
//: - Best case runtime is of complexity _Ω(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory,
/// using traditional `for`, and manual swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theClassic(var array: [Int]) -> [Int] {
    
    for var i = 0; i < array.count - 1; ++i {
        
        var minIndex = i
        
        for var j = i + 1; j < array.count; ++j {
            
            if array[j] < array[minIndex] {
                minIndex = j
            }
        }
        
        if i != minIndex {
            let temporary = array[minIndex]
            array[minIndex] = array[i]
            array[i] = temporary
        }
    }
    
    return array
}

// Already Sorted
assert(selectionSort_theClassic([Int]()).isSorted())
assert(selectionSort_theClassic([7]).isSorted())
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theClassic([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Random
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A nifty take on the classic, but strives to use more modern
/// laguage constructs, now using `guard`, `for-in`, and `swap`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theSwiftish(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    for i in 0..<array.count - 1 {
        
        var minIndex = i
        
        for j in (minIndex + 1)..<array.count {
            
            if array[j] < array[minIndex] {
                minIndex = j
            }
        }
        
        guard i != minIndex else {
            continue
        }
        
        swap(&array[i], &array[minIndex])
        
    }
    
    return array
}

// Already Sorted
assert(selectionSort_theSwiftish([Int]()).isSorted())
assert(selectionSort_theSwiftish([7]).isSorted())
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theSwiftish([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Random
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A highly creative approach that attempts to tap into the most powerful
/// features yet, now using `guard`, `for-in-where`, nested function, and
/// tuple swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theSwiftest(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    func findMinIndex(startIndex: Int) -> Int {
        var minIndex = startIndex
        
        for j in (minIndex + 1)..<array.count where array[j] < array[minIndex] {
            minIndex = j
        }

        return minIndex
    }
    
    for i in 0..<array.count - 1 {
        let minIndex = findMinIndex(i)
        
        guard i != minIndex else {
            continue
        }
        
        (array[i], array[minIndex]) = (array[minIndex], array[i])
    }

    return array
}

// Already Sorted
assert(selectionSort_theSwiftest([Int]()).isSorted())
assert(selectionSort_theSwiftest([7]).isSorted())
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13]).isSorted())

// Nearly Sorted
assert(selectionSort_theSwiftest([1, 2, 1, 3, 5, 13, 8]).isSorted())

// Reversed
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())

// Random
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status,
/// now using `guard`, `for-in-where`, nested function, tuple swapping, and Generics
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theGeneric<T: Comparable>(var array: [T]) -> [T] {
    
    guard array.count > 1 else {
        return array
    }
    
    func findMinIndex(startIndex: Int) -> Int {
        var minIndex = startIndex
        
        for j in (minIndex + 1)..<array.count where array[j] < array[minIndex] {
            minIndex = j
        }
        
        return minIndex
    }
    
    for i in 0..<array.count - 1 {
        let minIndex = findMinIndex(i)
        
        guard i != minIndex else {
            continue
        }
        
        (array[i], array[minIndex]) = (array[minIndex], array[i])
    }
    
    return array
}

// Already Sorted
assert(selectionSort_theGeneric([Int]()).isSorted())
assert(selectionSort_theGeneric([7]).isSorted())
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13]).isSorted())

assert(selectionSort_theGeneric([String]()).isSorted())
assert(selectionSort_theGeneric(["a"]).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"]).isSorted())

// Nearly Sorted
assert(selectionSort_theGeneric([1, 2, 1, 3, 5, 13, 8]).isSorted())
assert(selectionSort_theGeneric(["a", "b", "a", "c", "e", "d"]).isSorted())

// Reversed
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].reverse()).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].reverse()).isSorted())

// Random
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
