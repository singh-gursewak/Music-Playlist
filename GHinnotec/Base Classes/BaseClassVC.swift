//
//  BaseClassVC.swift


import UIKit
import AVKit


open class BaseClassVC: UIViewController{
    
    
    open override func viewDidLoad() {
        super.viewDidLoad()
      
    }
 
    
    @IBAction func action_Back() {
        self.popORDismiss()
       
    }
    
    
    @IBAction func action_ViewDismiss() {
        dismiss(animated: true, completion: nil)
    }
    
}

extension BaseClassVC {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
}

extension BaseClassVC {
    
    var isModal: Bool {
        if let index = navigationController?.viewControllers.firstIndex(of: self), index > 0 {
            return false
        } else if presentingViewController != nil {
            if let parent = parent, !(parent is UINavigationController || parent is UITabBarController) {
                return false
            }
            return true
        } else if let navController = navigationController, navController.presentingViewController?.presentedViewController == navController {
            return true
        } else if tabBarController?.presentingViewController is UITabBarController {
            return true
        }
        return false
    }
    
    func popORDismiss(){
        if isModal{
            self.dismiss(animated: true, completion: nil)
        }else{
            self.popToVC()
        }
    }
    
    func hideTabBar(_ status : Bool){
        if status{
            self.tabBarController?.tabBar.isHidden = true
             self.tabBarController?.tabBar.layer.zPosition = -1
        }else{
            self.tabBarController?.tabBar.isHidden = false
            self.tabBarController?.tabBar.layer.zPosition = -0
        }
    }
}

