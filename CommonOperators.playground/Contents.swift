import RxSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

//rxmarbles.com
let fruitObservable = Observable.of("🍎", "🍐", "🍊").subscribeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS:.Background))
let animalObservable = Observable.of("🐶", "🐱", "🐭", "🐹").subscribeOn(ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS:.Background))

//combining
[fruitObservable, animalObservable].combineLatest { (texts) -> String in
    return "\(texts[0])\(texts[1])"
}.subscribeNext { (combinedText) in
    print(combinedText)
}

//zipping
//[fruitObservable, animalObservable].zip { (texts) -> String in
//    return "\(texts[0])\(texts[1])"
//}.subscribeNext { (combinedText) in
//    print(combinedText)
//}

//flatMap
//fruitObservable.flatMap { (fruit) -> Observable<String> in
//    return animalObservable.map({ (animal) -> String in
//        return "flat mapped sequence \(fruit) \(animal)"
//    })
//}.subscribeNext { (combinedText) in
//    print(combinedText)
//}

//merging
//Observable.of(fruitObservable, animalObservable).merge().subscribeNext { (text) in
//    print(text)
//}

//concat
//fruitObservable.concat(animalObservable).subscribeNext { (text) in
//    print(text)
//}
