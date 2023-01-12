//
//  UIView+Extensions.swift
//  ImageBackgroundRemover
//
//  Created by Abdullah-Mamun on 11/1/23.
//

import Foundation
import UIKit


extension UIView {
    
    func  tap(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.handleTap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }

    @objc func handleTap(_ sender: MyTapGestureRecognizer) {
       sender.action!()
    }
}

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
}



