import UIKit

open class TabBarCoordinator: Coordinator {
    
    public weak var delegate: TabBarCoordinatorDelegate?
    
    public var tabBarController: UITabBarController { return viewController as! UITabBarController }
    private let tabBarControllerDelegateProxy = TabBarControllerDelegateProxy()
    
    open override func loadViewController() {
        viewController = UITabBarController()
    }
    
    open override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        
        tabBarControllerDelegateProxy.tabBarCoordinator = self
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
    
    
    public func addButton(for coordinator: Coordinator, at index: Int) {
        dummyIndices.append(index)
        
        let dc = Coordinator()
        dc.tabBarItem.image = coordinator.tabBarItem.image
        dc.tabBarItem.title = coordinator.tabBarItem.title
        dummyCoordinators.append(dc)
        
        buttonCoordinators.append(coordinator)
        
        guard coordinators!.count > 0 else { fatalError("Set the coordinators property prior to adding a button") }
        coordinators?.insert(dc, at: index)
    }
    var dummyIndices: [Int] = []
    var dummyCoordinators: [Coordinator] = []
    var buttonCoordinators: [Coordinator] = []
}




public protocol TabBarCoordinatorDelegate: class {
    func tabBarCoordinator(_ tabBarCoordinator: TabBarCoordinator, didSelect coordinator: Coordinator)
    func tabBarCoordinator(_ tabBarCoordinator: TabBarCoordinator, shouldSelect coordinator: Coordinator) -> Bool
}
public extension TabBarCoordinatorDelegate {
    func tabBarCoordinator(_ tabBarCoordinator: TabBarCoordinator, didSelect coordinator: Coordinator) { }
    func tabBarCoordinator(_ tabBarCoordinator: TabBarCoordinator, shouldSelect coordinator: Coordinator) -> Bool { return true }
}


class TabBarControllerDelegateProxy: NSObject, UITabBarControllerDelegate {
    weak var tabBarCoordinator: TabBarCoordinator!
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        guard let index = tabBarController.viewControllers?.index(of: viewController) else { fatalError() }
        guard let coordinator = tabBarCoordinator.coordinators?[index] else { fatalError() }
        tabBarCoordinator.delegate?.tabBarCoordinator(tabBarCoordinator, didSelect: coordinator)
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        guard let index = tabBarCoordinator.tabBarController.viewControllers?.index(of: viewController) else { fatalError() }
        guard let coordinator = tabBarCoordinator.coordinators?[index] else { fatalError() }
        //MARK: - Handling dummy buttons
        if let dummyIndex = tabBarCoordinator.dummyCoordinators.index(of: coordinator) {
            tabBarCoordinator.present(tabBarCoordinator.buttonCoordinators[dummyIndex], animated: true)
            return false
        }
        //MARK: - END Handling dummy buttons
        return tabBarCoordinator.delegate?.tabBarCoordinator(tabBarCoordinator, shouldSelect: coordinator) ?? true
    }
}
