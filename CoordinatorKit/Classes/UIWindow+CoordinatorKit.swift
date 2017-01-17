import UIKit

fileprivate let swizzling: (UIWindow.Type) -> () = { window in
    
    //    let originalSelector = #selector(window.
    //    let swizzledSelector = #selector(window.ck_setRootViewController(_:))
    //
    //    let originalMethod = class_getInstanceMethod(window, originalSelector)
    //    let sizzledMethod = class_getInstanceMethod(window, swizzledSelector)
    //
    //    method_exchangeImplementations(originalMethod, swizzledMethod)
}

extension UIWindow {
   
    open override class func initialize() {
        guard self === UIWindow.self else { return }
        swizzling(self)
    }
    
    private struct AssociatedKeys {
        static var rootCoordinator = "ck_rootCoordinator"
    }
    public var rootCoordinator: Coordinator? {
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.rootCoordinator) as? Coordinator
        }
        set {
            if let coordinator = newValue {
                objc_setAssociatedObject(self, &AssociatedKeys.rootCoordinator, coordinator, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            rootViewController = newValue?.viewController
        }
    }
}
