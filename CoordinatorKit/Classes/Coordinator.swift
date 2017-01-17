import UIKit

extension Coordinator: Equatable {
    public static func ==(lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs === rhs
    }
}

open class Coordinator {
    
    public var viewController: UIViewController! {
        set {
            if vc != nil {
                fatalError("You can't change your viewController after it is initially set")
            }
            vc = newValue
            vc.coordinator = self
        }
        get {
            if vc == nil {
                loadViewController()
                viewControllerDidLoad()
            }
            return vc
        }
    }
    private var vc: UIViewController!
    
    
    public init() {}
    
    open func loadViewController() {
        viewController = UIViewController()
    }
    open func viewControllerDidLoad() { }
    
    open func willNavigateToViewController(_ animated: Bool) { }
    
    open func didNavigateToViewController(_ animated: Bool) { }
    
    open func willNavigateAwayFromViewController(_ animated: Bool) { }
    
    open func didNavigateAwayFromViewController(_ animated: Bool) { }
    
    public var navigationItem: UINavigationItem { return viewController.navigationItem }
    public var tabBarItem: UITabBarItem { return viewController.tabBarItem }
    
    // Presenting Coordinators
    
    var presentedCoordinator: Coordinator? {
        didSet {
        }
    }
    
    public func show(_ coordinator: Coordinator, sender: Any?) {
        if let nc = navigationCoordinator {
            nc.pushCoordinator(coordinator, animated: true)
        } else {
            present(coordinator, animated: true)
        }
    }
    public func showDetailCoordinator(_ coordinator:Coordinator, sender: Any?) {
            fatalError("NYI")
        if let svc = splitViewCoordinator {
            ///
        } else if let nc = navigationCoordinator {
            nc.pushCoordinator(coordinator, animated: true)
        } else {
            present(coordinator, animated: true)
        }
    }
    public func present(_ coordinatorToPresent: Coordinator, animated flag: Bool, completion: (() -> Void)? = nil) {
        coordinatorToPresent.willNavigateToViewController(flag)
        presentedCoordinator = coordinatorToPresent
        coordinatorToPresent.parentCoordinator = self
        viewController.present(coordinatorToPresent.viewController, animated: flag, completion: completion)
        coordinatorToPresent.didNavigateToViewController(flag)
    }
    
    public func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        guard let pc = presentedCoordinator else { fatalError() }
        pc.willNavigateAwayFromViewController(flag)
        pc.parentCoordinator = nil
        presentedCoordinator = nil
        viewController.dismiss(animated: flag, completion: completion)
        pc.didNavigateAwayFromViewController(flag)
    }
    
    public weak var parentCoordinator: Coordinator?
    public var navigationCoordinator: NavigationCoordinator? {
        if let selfNav = self as? NavigationCoordinator {
            return selfNav
        } else {
            var parent = parentCoordinator
            while let par = parent {
                if let parentNav = par as? NavigationCoordinator {
                    return parentNav
                } else {
                    parent = par.parentCoordinator
                }
            }
        }
        return nil
    }
    public var splitViewCoordinator: SplitViewCoordinator? {
        if let selfSVC = self as? SplitViewCoordinator {
            return selfSVC
        } else {
            var parent = parentCoordinator
            while let par = parent {
                if let parentSVC = par as? SplitViewCoordinator {
                    return parentSVC
                } else {
                    parent = par.parentCoordinator
                }
            }
        }
        return nil
    }
}



    
