//
//  UIViewControllerExtensions.swift
//  AI Editor
//
//  Created by Muhammad Mamun on 12/1/23.
//

import Foundation
import UIKit


extension UIViewController{
    
       func nextVCwithStoryboardID(_ vc: String) {
           let storyboard = UIStoryboard(name:"Main", bundle: nil)
           let nextVC = storyboard.instantiateViewController(withIdentifier: "\(vc)")
           navigationController?.pushViewController(nextVC, animated: true)
       }
}

protocol Storyboarded { }

extension Storyboarded where Self: UIViewController {
    
    static func instantiateFromMain() -> Self {
        let storyboardIdentifier = String(describing: self)
        // `Main` can be your stroyboard name.
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as? Self else {
            fatalError("No storyboard with this identifier ")
        }
        return vc
    }
}
// Make a ViewController extension to use on all of your ViewControllers
extension UIViewController: Storyboarded {}
