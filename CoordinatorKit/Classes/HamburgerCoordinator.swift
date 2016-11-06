import UIKit

class HamburgerCoordinator: Coordinator {
   
    var hamburgerController: HamburgerController { return viewController as! HamburgerController }
    
    override func loadViewController() {
        viewController = HamburgerController()
    }

}


class HamburgerController: UIViewController {
    
    var tableView = UITableView(frame: CGRect(), style: .plain)
    var containerView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
    }
    
    var viewControllers: [UIViewController]?
    
    
    
}
