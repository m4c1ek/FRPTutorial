import RxSwift
import XCPlayground
import Foundation

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

func observable() -> Observable<Int> {
    return Observable<Int>.create { observer in
        let diceRoll = Int(arc4random_uniform(10))
        if diceRoll % 7 != 0 {
            observer.onNext(diceRoll)
        } else {
            observer.onError(NSError(domain: "Not7Domain", code: 1000, userInfo: nil) )
        }
        return NopDisposable.instance
    }
}

let subscription = Observable<Int>.interval(1, scheduler: ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)).flatMapLatest { (number) -> Observable<Int> in
    return observable()
    }

subscription
    .subscribe(
    onNext: { (number) in
        print(number)
    }, onError: { (error) in
        print(error)
    }, onCompleted: {
        print("completed")
    }, onDisposed:{
        print("disposed")
})

//1. try to ignore the error and send the number 100 instead
//2. try to send two numbers instead of the error