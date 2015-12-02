//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # Selection Sort
//: ----
//:
//: ### About
//:
//: - Based on the idea that the input array is divided into two portions, one sorted and on unsorted
//: - Initially, the sorted portion is empty, while the unsorted portion contains all the elements
//: - Finds the smallest element in the unsorted portion and moves it to the end of the sorted portion of the array
//: - Eventually, the unsorted portion becomes empty and the array sorted in-place
//:
//:
//: ### Pseudocode
//:
//:    take in an array that is considered unsorted
//:
//:    return the array if empty or contains a single element
//:
//:    for i = 0 to n - 1
//:
//:      index of the smallest element = i
//:
//:      for j = i + 1 to n
//:
//:        if array[j] < array[index]
//:
//:          update index of the smallest element = j
//:
//:      if i != index
//:
//:        swap array[i] and array[index]
//:
//:    return sorted array
//:
//:
//: ### Optimizations
//:
//: - Early return in case the input array is empty or contains a single element, for it is sorted
//: - The number of passes through the array needed is the same as to the maximum number of swaps required
//: - Swap only takes place when the smallest element is not already in its correct location
//:
//:
//: ### Properties
//:
//: - Simple, both concept and implementation are relatively easily understood
//: - Not Adaptative, as it does not benefit from the presortedness in the input array
//: - Not Stable, as it does not preserve the relative order of elements of the input array
//: - The best and worst case runtime are respectively of complexity _Ω(n²)_ and _O(n²)_

/// The Classic Algorithm
///
/// A die-hard style, rooted in tradition, in all its imperative glory
///
/// This version showcases `if` early exit, old-fashioned `for`, and
/// manual swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order
///
/// - todo: Remove code annotations

func selectionSort_theClassic(array: [Int]) -> [Int] {

    // takes in an array that is considered unsorted and makes it mutable so it can be sorted in-place
    var array = array

    // returns the array if it is empty or contains a single element, for it is sorted
    if array.count <= 1 {
        return array
    }

    // iterates through the elements of the unsorted portion of the array, except the last, which is considered sorted
    for var i = 0; i < array.count - 1; ++i {
        
        // considers the first element of the unsorted portion to be the smallest
        var indexOfTheSmallestElement = i

        // iterates thorugh the unsorted portion to find the smallest unsorted element
        for var j = i + 1; j < array.count; ++j {

            // compares the current element with the considered smallest element
            if array[j] < array[indexOfTheSmallestElement] {

                // remembers the current element as the new smallest one
                indexOfTheSmallestElement = j
            }
        }

        // checks if the smallest element is already in its correct location
        if i != indexOfTheSmallestElement {
            
            // swaps the smallest element with the first unsorted element, thereby appending to the sorted portion
            let temporary = array[indexOfTheSmallestElement]
            array[indexOfTheSmallestElement] = array[i]
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

// Shuffled
assert(selectionSort_theClassic([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swift-ish Algorithm
///
/// A sligthly more modern take on the classic, but still not quite quaint enough
///
/// This version showcases `var` argument, `guard`, `for-in`, and `swap`
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theSwiftish(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }
    
    for i in 0..<array.count - 1 {
        
        var indexOfTheSmallestElement = i
        
        for j in (indexOfTheSmallestElement + 1)..<array.count {
            
            if array[j] < array[indexOfTheSmallestElement] {
                indexOfTheSmallestElement = j
            }
        }
        
        guard i != indexOfTheSmallestElement else {
            continue
        }
        
        swap(&array[i], &array[indexOfTheSmallestElement])
        
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

// Shuffled
assert(selectionSort_theSwiftish([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Swiftest Algorithm
///
/// A nifty approach that attempts to tap into the most powerful language features yet
///
/// This version showcases `var` argument, `guard`, `for-in-where`, nested function,
/// and tuple swapping
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theSwiftest(var array: [Int]) -> [Int] {
    
    guard array.count > 1 else {
        return array
    }

    func indexOfTheSmallestElement(startIndex index: Int) -> Int {

        var indexOfTheSmallestElement = index
        
        for j in (indexOfTheSmallestElement + 1)..<array.count where array[j] < array[indexOfTheSmallestElement] {
            indexOfTheSmallestElement = j
        }

        return indexOfTheSmallestElement
    }
    
    for i in 0..<array.count - 1 {

        let indexOfTheSmallestElement = indexOfTheSmallestElement(startIndex: i)
        
        guard i != indexOfTheSmallestElement else {
            continue
        }
        
        (array[i], array[indexOfTheSmallestElement]) = (array[indexOfTheSmallestElement], array[i])
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

// Shuffled
assert(selectionSort_theSwiftest([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())


/// The Generic Algorithm
///
/// A play on the swiftest version, but elevated to a type-agnostic nirvana status
///
/// This version showcases `var` argument, `guard`, `for-in-where`, nested function,
/// tuple swapping, and generics
///
/// - parameter array: The `array` to be sorted in-place
///
/// - returns: The `array` with elements sorted in ascending order

func selectionSort_theGeneric<T: Comparable>(var array: [T]) -> [T] {
    
    guard array.count > 1 else {
        return array
    }
    
    func indexOfTheSmallestElement(startIndex index: Int) -> Int {

        var indexOfTheSmallestElement = index

        for j in (indexOfTheSmallestElement + 1)..<array.count where array[j] < array[indexOfTheSmallestElement] {
            indexOfTheSmallestElement = j
        }

        return indexOfTheSmallestElement
    }

    for i in 0..<array.count - 1 {

        let indexOfTheSmallestElement = indexOfTheSmallestElement(startIndex: i)

        guard i != indexOfTheSmallestElement else {
            continue
        }

        (array[i], array[indexOfTheSmallestElement]) = (array[indexOfTheSmallestElement], array[i])
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

// Shuffled
assert(selectionSort_theGeneric([1, 1, 2, 3, 5, 8, 13].shuffle()).isSorted())
assert(selectionSort_theGeneric(["a", "a", "b", "c", "d", "e"].shuffle()).isSorted())

//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
