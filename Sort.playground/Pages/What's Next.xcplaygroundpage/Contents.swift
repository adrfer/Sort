
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous) | [Next](@next)
//:
//: ----
//: # What's Next
//: ----
//:
//: Here are some future ideas yet to be implemented, that's all.
//:
//: ### Current
//: - Review and/or include an implementation that takes a closure (or predicate), similar to `sort` from the [Swift Standard Library](https://developer.apple.com/library/ios//documentation/Swift/Reference/Swift_MutableCollectionType_Protocol/index.html#//apple_ref/swift/intfm/MutableCollectionType/s:FeRq_Ss21MutableCollectionTypeqq_Ss16MutableIndexable5IndexSs21RandomAccessIndexType_SsS_9partitionuRq_S_qq_S0_5IndexS1__FRq_FTGVSs5Rangeqq_S0_5Index_15isOrderedBeforeFTqqq_Ss14CollectionType9GeneratorSs13GeneratorType7Elementqqq_S3_9GeneratorS4_7Element_Sb_qq_S0_5Index).
//: - Review and/or include a functional implementation, including aspects as no side-effects, immutability, and reusable/composable functions.
//: - Refator tests into its own playground page.
//:
//: ### Other
//: - Heap Sort
//: - Shell Sort
//:
//: ----
//: [Table of Contents](Table%20of%20Contents) | [Previous](@previous)

//typealias UnsortedArray = [Int]
//typealias SortedArray = [Int]
//
//func selectionSort(array: UnsortedArray) -> SortedArray {




var array = [1, 3, 4, 5, 8, 2, 4, 0, 9, -1, 5, 6, 7, 7, 7, 7, 198, 6]

for i in 0..<array.count {

    let newArray = array[0..<array.count - i]

    if let minElement = newArray.minElement(), indexOfMinElement = newArray.indexOf(minElement) {
        array.removeAtIndex(indexOfMinElement)
        array.append(minElement)
    }
}


array
