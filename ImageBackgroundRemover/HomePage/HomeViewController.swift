//
//  ViewController.swift
//  ImageBackgroundRemover
//
//  Created by Abdullah-Mamun on 22/12/22.
//

import UIKit
import MobileCoreServices
import AVFoundation
import Photos
import UniformTypeIdentifiers
import CoreML
import DKImagePickerController
import Photos

@available(iOS 15.0, *)
class HomeViewController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    let semanticImage = SemanticImage()
    
    var myCaptureImage:UIImage = UIImage()
    let model: DeepLabV3 = try! DeepLabV3(configuration: MLModelConfiguration.init())
    let context = CIContext(options: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func openCamera(_ sender: UIButton) {
//        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
//        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
//            self.openCamera()
//            
//        }))
//        
//        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
//            self.openGallary()
//        }))
//        
//        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
//        
//        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
//        switch UIDevice.current.userInterfaceIdiom {
//        case .pad:
//            alert.popoverPresentationController?.sourceView = sender
//            alert.popoverPresentationController?.sourceRect = sender.bounds
//            alert.popoverPresentationController?.permittedArrowDirections = .up
//        
//        default:
//            break
//        }
//        
//        self.present(alert, animated: true, completion: nil)
        
        
        let pickerController = DKImagePickerController()

        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
           // print(assets)
        }
        pickerController.sourceType = .camera

        self.present(pickerController, animated: true) {}

    }
    
    
    @IBAction func RemoveBG(_ sender: UIButton) {
//        let maskImage:UIImage? = BackgroundRemoval.init().removeBackground(image: myCaptureImage)
//        img.image = maskImage
        
        img.image  = self.removeBackground(image: myCaptureImage)
    }
    
    
    
    @IBAction func BGBlur(_ sender: UIButton) {
        let blurredPersonImage:UIImage? = semanticImage.personBlur(uiImage:myCaptureImage, intensity:95.0)
        img.image = blurredPersonImage
    }
    
    
    
    
    

}

@available(iOS 15.0, *)
extension HomeViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate{
 
    //MARK: - Open the camera
    func openCamera(){
        
//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
//            let pickerController = UIImagePickerController()
//            // Part 1: File origin
//            pickerController.sourceType = .camera
//            // Part 3: camera settings
//            pickerController.cameraCaptureMode = .photo // Default media type .photo vs .video
//            pickerController.cameraDevice = .rear // rear Vs front
//            pickerController.cameraFlashMode = .auto // on, off Vs auto
//            pickerController.allowsEditing = false
//            pickerController.delegate = self
//            pickerController.modalPresentationStyle = .fullScreen
//
//
//
//            present(pickerController, animated: true, completion: nil)
//        }
//        else{
//            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
        
        let pickerController = DKImagePickerController()
        
        DKImageExtensionController.registerExtension(extensionClass: CustomCameraExtension.self, for: .camera)
        //self.present(pickerController, animated: true, completion: nil)
        //self.present(pickerController, animated: true)
        //destination.pickerController = pickerController
        
        //let pickerController = DKImagePickerController()

        pickerController.didSelectAssets = { (assets: [DKAsset]) in
            print("didSelectAssets")
            print(assets)
        }

        self.present(pickerController, animated: true) {}
    }
    
    
    //MARK: - Choose image from camera roll
    
    func openGallary(){
        if(UIImagePickerController .isSourceTypeAvailable(.savedPhotosAlbum)){
            let pickerController = UIImagePickerController()
            pickerController.sourceType = .savedPhotosAlbum
            pickerController.allowsEditing = false
            pickerController.delegate = self
            pickerController.modalPresentationStyle = .fullScreen
            present(pickerController, animated: true, completion: nil)
            
            
        }
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
      
      // Check for the media type
      let mediaType = info[UIImagePickerController.InfoKey.mediaType] as! String
      switch mediaType {
          
      case UTType.image.identifier:

          let originalImage = info[.originalImage] as! UIImage
          img.image = originalImage
          myCaptureImage = originalImage

      case UTType.movie.identifier:
          break
        
      default:
        print("Mismatched type: \(mediaType)")
      }

      picker.dismiss(animated: true, completion: nil)
    }
}

