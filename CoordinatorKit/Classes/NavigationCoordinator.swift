import UIKit

open class NavigationCoordinator: Coordinator {
    
    public var navigationController: UINavigationController! { return viewController as! UINavigationController }
    
    public override init() {
        super.init()
    }
    public init(rootCoordinator: Coordinator) {
        super.init()
        self.pushCoordinator(rootCoordinator, animated: false)
    }
    
    open override func loadViewController() {
        viewController = UINavigationController()
    }
    open override func viewControllerDidLoad() {
        super.viewControllerDidLoad()
        interactivePopGestureRecognizer?.addTarget(self, action: #selector(NavigationCoordinator.popGestureRecognized(_:)))
    }
    
    //Implementation
    @objc private func popGestureRecognized(_ gr: UIGestureRecognizer) {
        _ = popCoordinator(animated: true)
    }
    
    //Accessing Items on the Navigation Stack - Coordinators
    public var topCoordinator: Coordinator? { return coordinators.first }
    public var visibleCoordinator: Coordinator? { return coordinators.last }
    public var coordinators = [Coordinator]()
    public func setCoordinators(_ coordinators: [Coordinator], animated: Bool) {
        for i in 1..<(coordinators.count) {
            coordinators[i].parentCoordinator = coordinators[i-1]
        }
        if let first = coordinators.first {
            first.parentCoordinator = self
        }
        let vcs = coordinators.map { $0.viewController! }
        navigationController.setViewControllers(vcs, animated: animated)
    }
    
    // Pushing and Popping Stack Items
    public func pushCoordinator(_ coordinator: Coordinator, animated: Bool) {
        if let last = coordinators.last {
            coordinator.parentCoordinator = last
        } else {
            coordinator.parentCoordinator = self
        }
        coordinators.append(coordinator)
        navigationController.pushViewController(coordinator.viewController, animated: true)
    }
    public func popCoordinator(animated: Bool) -> Coordinator? {
        navigationController.popViewController(animated: true)
        return coordinators.popLast()
    }
    public func popToRootCoordinator(animated: Bool) -> [Coordinator]? {
        _ = navigationController.popToRootViewController(animated: animated)
        let last = Array(coordinators.suffix(from: 1))
        coordinators = [coordinators[0]]
        return last
    }
    public func popToCoordinator(_ coordinator: Coordinator, animated: Bool) -> [Coordinator]? {
        guard let index = coordinators.index(of: coordinator) else { return nil }
        let removed = Array(coordinators.suffix(from: index))
        coordinators = Array(coordinators.prefix(upTo: index))
        return removed
    }
    public var interactivePopGestureRecognizer: UIGestureRecognizer? {
        let gr = navigationController.interactivePopGestureRecognizer
        return gr
    }
    
    
    open override func willNavigateToViewController(_ animated: Bool) {
        super.willNavigateToViewController(animated)
        topCoordinator?.willNavigateToViewController(true)
    }
    open override func didNavigateToViewController(_ animated: Bool) {
        super.didNavigateToViewController(animated)
        topCoordinator?.didNavigateToViewController(animated)
    }
    open override func willNavigateAwayFromViewController(_ animated: Bool) {
        super.willNavigateAwayFromViewController(animated)
        topCoordinator?.willNavigateAwayFromViewController(animated)
    }
    open override func didNavigateAwayFromViewController(_ animated: Bool) {
        super.didNavigateAwayFromViewController(animated)
        topCoordinator?.didNavigateAwayFromViewController(animated)
    }
}
