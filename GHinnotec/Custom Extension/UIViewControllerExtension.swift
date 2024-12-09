//
//  UIViewControllerExtension.swift

import UIKit

extension UIViewController {
    
   
    func topMostViewController() -> UIViewController? {
        if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.topMostViewController()
        }
        else if let tabBarController = self as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return selectedViewController.topMostViewController()
            }
            return tabBarController.topMostViewController()
        }
        
        else if let presentedViewController = self.presentedViewController {
            return presentedViewController.topMostViewController()
        }
        
        else {
            return self
        }
    }
    
    func openViewControllerBasedOnIdentifier(_ strIdentifier:String) -> UIViewController {
        var viewController = UIViewController()
        
        if #available(iOS 13.0, *) {
            if let destViewController : UIViewController = self.storyboard?.instantiateViewController(identifier: strIdentifier){
                viewController = destViewController
                self.navigationController?.pushViewController(destViewController, animated: false)
            }
        }
        else{
            if let destViewController : UIViewController = self.storyboard?.instantiateViewController(withIdentifier: strIdentifier) {
                viewController = destViewController
                self.navigationController?.pushViewController(destViewController, animated: false)
            }
        }
        return viewController
    }
    
 
   

    
    func openViewControllerBasedOnStoryBoard(_ strIdentifier:String, _ storyBoard:String) -> UIViewController {
        var viewController = UIViewController()
        
        let storyBoard:UIStoryboard? = UIStoryboard.init(name: storyBoard, bundle: Bundle.main)
        
        if #available(iOS 13.0, *) {
            
            if let destViewController : UIViewController = storyBoard?.instantiateViewController(identifier: strIdentifier){
                viewController = destViewController
                self.navigationController?.pushViewController(destViewController, animated: false)
            }
        }
        else{
            if let destViewController : UIViewController = storyBoard?.instantiateViewController(withIdentifier: strIdentifier) {
                viewController = destViewController
                self.navigationController?.pushViewController(destViewController, animated: false)
            }
        }
        return viewController
    }
 
    
    func presentViewControllerBasedOnStoryBoard(_ strIdentifier:String, _ storyBoard:String) -> UIViewController {
        var viewController = UIViewController()
        let storyBoard:UIStoryboard? = UIStoryboard.init(name: storyBoard, bundle: Bundle.main)
        if #available(iOS 13.0, *) {
            if let destViewController : UIViewController = storyBoard?.instantiateViewController(identifier: strIdentifier){
                viewController = destViewController
                let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
                navigationController.modalPresentationStyle = .fullScreen
                // navigationController.modalTransitionStyle = .crossDissolve
                navigationController.isNavigationBarHidden = true
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        else{
            if let destViewController : UIViewController = storyBoard?.instantiateViewController(withIdentifier: strIdentifier) {
                viewController = destViewController
                let navigationController: UINavigationController = UINavigationController(rootViewController: viewController)
                navigationController.isNavigationBarHidden = true
                navigationController.modalPresentationStyle = .fullScreen
                self.present(navigationController, animated: true, completion: nil)
            }
        }
        return viewController
    }
    
    
    
    func popToVC(){
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func navigationBarHiddenStatus(_ status:Bool){
        self.navigationController?.setNavigationBarHidden(status, animated: false)
    }
    
    @objc func backPressed()
    {
        print("Back pressed.")
        self.popToVC()
    }
    
    
   
    
    func runOnMain(complete:@escaping () -> Void)
    {
        DispatchQueue.main.async {
            complete()
        }
    }
    
    
    func showAlert(message:String,title:String) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction.init(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func presentAlertWithTitle(title: String, message: String, options: String..., completion: @escaping (Int) -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, option) in options.enumerated() {
            alertController.addAction(UIAlertAction.init(title: option, style: .default, handler: { (action) in
                completion(index)
            }))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
}


