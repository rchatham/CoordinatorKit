import UIKit

//MARK: - Swizzling
fileprivate let swizzling: (UIViewController.Type) -> () = { viewController in
    
    let swizzle: (Selector,Selector) -> () = { first, second in
        let originalMethod = class_getInstanceMethod(viewController, first)
        let swizzledMethod = class_getInstanceMethod(viewController, second)
        
        method_exchangeImplementations(originalMethod, swizzledMethod)
    }
    
    let vwa = #selector(viewController.viewWillAppear(_:))
    let vwa2 = #selector(viewController.ck_viewWillAppear(_:))
   
    let vda = #selector(viewController.viewDidAppear(_:))
    let vda2 = #selector(viewController.ck_viewDidAppear(_:))
   
    let vwd = #selector(viewController.viewWillDisappear(_:))
    let vwd2 = #selector(viewController.ck_viewWillDisappear(_:))
    
    let vdd = #selector(viewController.viewDidDisappear(_:))
    let vdd2 = #selector(viewController.ck_viewDidDisappear(_:))
    
    for (l,r) in [(vwa,vwa2),(vda,vda2),(vwd,vwd2),(vdd,vdd2)] {
        swizzle(l,r)
    }
}

extension UIViewController {
    
    func ck_viewWillAppear(_ animated: Bool) {
        print("Swizzled vwa")
        coordinator.willNavigateToViewController(animated)
        ck_viewWillAppear(animated)
    }
    func ck_viewDidAppear(_ animated: Bool) {
        print("Swizzled vda")
        coordinator.didNavigateToViewController(animated)
        ck_viewDidAppear(animated)
    }
    func ck_viewWillDisappear(_ animated: Bool) {
        print("Swizzled vwd")
        coordinator.willNavigateAwayFromViewController(animated)
        ck_viewWillDisappear(animated)
    }
    func ck_viewDidDisappear(_ animated: Bool) {
        print("Swizzled vdd")
        coordinator.didNavigateAwayFromViewController(animated)
        ck_viewDidDisappear(animated)
    }
    
    open override class func initialize() {
        swizzling(self)
    }
}

//MARK: - Associated Objects
extension UIViewController {
    private struct AssociatedKeys {
        static var coordinator = "ck_coordinator"
    }
    public var coordinator: Coordinator! {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.coordinator) as! Coordinator
        }
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.coordinator, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
