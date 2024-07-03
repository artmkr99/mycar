//
//  NSObject+Rx.swift
//  CocoaExtensions
//
//  Created by Abdurahim Jauzee on 12/11/2017.
//

import RxSwift

public extension NSObject {
    private struct AssociatedKeys {
        static var DisposeBag = "rx_disposeBag"
    }
    
    func doLocked(_ closure: () -> Void) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        closure()
    }
    
    var bag: DisposeBag {
        get {
            var disposeBag: DisposeBag!
            doLocked {
                let lookup = objc_getAssociatedObject(self, &AssociatedKeys.DisposeBag) as? DisposeBag
                if let lookup = lookup {
                    disposeBag = lookup
                } else {
                    let newDisposeBag = DisposeBag()
                    self.bag = newDisposeBag
                    disposeBag = newDisposeBag
                }
            }
            return disposeBag
        } set {
            doLocked {
                objc_setAssociatedObject(self, &AssociatedKeys.DisposeBag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
        }
    }
}

public extension Reactive where Base: NSObject {
    var disposeBag: DisposeBag {
        return base.bag
    }
}
