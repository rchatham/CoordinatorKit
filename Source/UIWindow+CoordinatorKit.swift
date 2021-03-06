import UIKit

//MARK: - Swizzling
fileprivate let swizzling: (UIWindow.Type) -> () = { window in
    
    let originalSelector = #selector(window.makeKeyAndVisible)
    let swizzledSelector = #selector(window.ck_makeKeyAndVisible)
    
    let originalMethod = class_getInstanceMethod(window, originalSelector)
    let swizzledMethod = class_getInstanceMethod(window, swizzledSelector)
    
    method_exchangeImplementations(originalMethod, swizzledMethod)
}
extension UIWindow {
    
    func ck_makeKeyAndVisible() {
        guard rootCoordinator != nil else { fatalError("You must set a rootCoordinator before making the UIWindow key and visible") }
        ck_makeKeyAndVisible()
    }
    
    open override class func initialize() {
        guard self === UIWindow.self else { return }
        swizzling(self)
    }
}

// MARK: - Associated Objects
extension UIWindow {
    
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
