//
//  MainViewControlller.swift
//  ImageBackgroundRemover
//
//  Created by Abdullah-Mamun on 11/1/23.
//

import UIKit
import MobileCoreServices
import Photos
import UniformTypeIdentifiers
import DKImagePickerController

class MainViewControlller: UIViewController {
    
    @IBOutlet weak var gallaryView: UIView!
    
    @IBOutlet weak var cameraView: UIView!
    
    @IBOutlet weak var historyView: UIView!
    
    @IBOutlet weak var themeView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpView()
        self.addViewAction()
        
    }
    
    
    private func addViewAction(){
        
        /// gallary Action
        gallaryView.tap {
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .savedPhotosAlbum
            pickerController.allowsEditing = false
            pickerController.delegate = self
            pickerController.modalPresentationStyle = .fullScreen
            self.present(pickerController, animated: true, completion: nil)
        }
        
        
        ///camera action
        cameraView.tap {
            let pickerController = DKImagePickerController()

            pickerController.didSelectAssets = { (assets: [DKAsset]) in
                
                for asset in assets{
                    asset.fetchOriginalImage { image, info in
                        let image:UIImage = image ?? UIImage()
                        self.goToAIEditorVC(img: image)
                    }
                }
            }
            pickerController.sourceType = .camera
            pickerController.modalPresentationStyle = .fullScreen

            self.present(pickerController, animated: true)
        }
    }
    
    func goToAIEditorVC(img: UIImage){
        let vc = AIEditorViewController.instantiateFromMain()
        vc.bufferImage = img
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
   
}


/// Gallary Picker Delegate
extension MainViewControlller:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
        let mediaType = info[.mediaType] as! String
        
        switch mediaType {
            
        case UTType.image.identifier:
            
            let originalImage = info[.originalImage] as! UIImage
            picker.dismiss(animated: true, completion: nil)
            goToAIEditorVC(img: originalImage)
            
        case UTType.movie.identifier:
            break
            
        default:
            print("Mismatched type: \(mediaType)")
        }
        
    }
}

