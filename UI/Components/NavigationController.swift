//
//  NavigationController.swift
//  UI
//
//  Created by Wagner Coleta on 12/03/22.
//

import Foundation
import UIKit

public final class NavigationController: UINavigationController {
    
    private var currentViewController: UIViewController?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    public convenience init() {
        self.init(nibName: nil, bundle: nil)
    }
    
    func setup() {
        navigationBar.barTintColor = Color.primary
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationBar.isTranslucent = false
        navigationBar.barStyle = .black
    }
    
    public func setRootViewController(_ viewController: UIViewController) {
        setViewControllers([viewController], animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }
    
    public func pushViewController(_ viewController: UIViewController) {
        pushViewController(viewController, animated: true)
        currentViewController = viewController
        hideBackButtonText()
    }
    
    private func hideBackButtonText() {
        currentViewController?.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
    }
}
