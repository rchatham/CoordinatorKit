import UIKit

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
