import Foundation
import RxSwift

private class RACReachability {
    static let sharedInstance = RACReachability()
    
    private let reachability:Reachability? = Reachability.reachabilityForInternetConnection()
    private let reachable = Variable<Bool>(true)
    
    init() {
        reachability?.startNotifier()
        reachability?.whenUnreachable = { [weak self] reachability in
            self?.reachable.value = false
        }
        reachability?.whenReachable = { [weak self] reachability in
            self?.reachable.value = true
        }
    }
    
    deinit {
        reachability?.stopNotifier()
    }
}

extension Reachability {
    static func reachabilityObservable() -> Observable<Bool> {
        return RACReachability.sharedInstance.reachable.asObservable().distinctUntilChanged()
    }
}
