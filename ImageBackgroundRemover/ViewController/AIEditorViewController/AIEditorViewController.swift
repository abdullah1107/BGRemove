//
//  AIEditorViewController.swift
//  ImageBackgroundRemover
//
//  Created by Abdullah-Mamun on 11/1/23.
//

import UIKit

class AIEditorViewController: UIViewController {
    
    
    @IBOutlet weak var scrollImageView: UIView!
    
    @IBOutlet weak var footerView: UIView!
    
    var scrollView = ImageScrollView(image: UIImage(named: "model")!)
    
    
    @IBOutlet weak var removeBackGroundView: UIView!
    
    @IBOutlet weak var blurBackgroundView: UIView!
    
    @IBOutlet weak var backGroundCollection: UICollectionView!
    
    var bufferImage:UIImage = UIImage()
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView = ImageScrollView(image: bufferImage)
        
        self.setUpScrollImageView()
        removeBackGroundView.layer.cornerRadius = 10.0
        blurBackgroundView.layer.cornerRadius = 10.0
    }
    
    
    override func viewDidLayoutSubviews() {
        scrollView.setZoomScale()
    }
    
    
    
}
