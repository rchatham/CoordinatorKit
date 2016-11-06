import UIKit

open class TabBarCoordinator: Coordinator {
    
    public var tabBarController: UITabBarController { return viewController as! UITabBarController }
    private var tabBarControllerDelegateProxy: TabBarControllerDelegateProxy!
    
    public override init() {
        super.init()
        self.viewController = UITabBarController()
    }
    open override func loadViewController() {
        tabBarControllerDelegateProxy = TabBarControllerDelegateProxy()
        tabBarControllerDelegateProxy.tabBarCoordinator = self
        
        viewController = UITabBarController()
        tabBarController.delegate = tabBarControllerDelegateProxy
    }
    
    
    //Manaing the Coordinators
    public var coordinators: [Coordinator]? = [Coordinator]() {
        didSet {
            tabBarController.viewControllers = coordinators.map { unwrapped in unwrapped.map { coordinator in coordinator.viewController! } }
        }
    }
    public func setCoordinators(_ coordinators: [Coordinator]?, animated: Bool) {
        self.coordinators = coordinators
        tabBarController.viewControllers = coordinators.map { unwrapped in unwrapped.map { coordinator in coordinator.viewController! } }
    }
    
    //Managing the Selected Tab
    public var selectedCoordinator: Coordinator? {
        get {
            return coordinators?[selectedIndex]
        }
        set {
            guard let coordinator = newValue else { fatalError() }
            selectedIndex = (coordinators?.index(of: coordinator))!
        }
    }
    public var selectedIndex: Int {
        get { return tabBarController.selectedIndex }
        set { tabBarController.selectedIndex = newValue }
    }
}


class TabBarControllerDelegateProxy: NSObject, UITabBarControllerDelegate {
    weak var tabBarCoordinator: TabBarCoordinator!
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        tabBarCoordinator.selectedCoordinator?.willNavigateAwayFromViewController(false)
        guard let index = tabBarCoordinator.tabBarController.viewControllers?.index(of: viewController) else { fatalError() }
        guard let new = tabBarCoordinator.coordinators?[index] else { fatalError() }
        new.willNavigateToViewController(false)
    }
}
