//
//  AIEditor+Extensions.swift
//  AI Editor
//
//  Created by Muhammad Mamun on 11/1/23.
//

import Foundation
import UIKit


extension AIEditorViewController{
    
    func setUpScrollImageView(){
        
        scrollImageView.backgroundColor = .systemBackground
        scrollImageView.addSubview(scrollView)
        scrollView.frame = scrollImageView.frame
        
        //scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: scrollImageView.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: scrollImageView.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: scrollImageView.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: scrollImageView.bottomAnchor).isActive = true
    }
}
