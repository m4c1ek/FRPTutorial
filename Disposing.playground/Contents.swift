import RxSwift
import XCPlayground

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true

let subscription = Observable<Int>.interval(1, scheduler: ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)).subscribeNext { number in
    print(number)
}

Observable<Int>.interval(4, scheduler: ConcurrentDispatchQueueScheduler(globalConcurrentQueueQOS: .Default)).take(1).subscribeNext { _ in
    subscription.dispose()
}

//1. dispose with subscription.dispose()
//2. dispose with dispose bag
//3. dispose with takeUntil