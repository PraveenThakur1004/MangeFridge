//
//  SignUpViewController+Extension.swift
//  MangeFridge
//
//  Created by MAC on 09/11/17.
//  Copyright © 2017 Orem. All rights reserved.
//

import Foundation
extension SignUpViwController{
    func showActionSheet(){
        let alert:UIAlertController=UIAlertController(title: "Choose Image", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openCamera()
            
        }
        let GalleryAction = UIAlertAction(title: "Gallery", style: UIAlertActionStyle.default)
        {
            UIAlertAction in
            self.openGallery()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel)
        {
            UIAlertAction in
            
        }
        // Add the actions
        
        picker.allowsEditing = true
        picker.delegate = self
        alert.addAction(cameraAction)
        alert.addAction(GalleryAction)
        alert.addAction(cancelAction)
        // Present the controller
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(alert, animated: true, completion: nil)
        }
        
    }
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera))
        {
            picker.sourceType = UIImagePickerControllerSourceType.camera
            self .present(picker, animated: true, completion: nil)
        }
        else
        {
            openGallery()
        }
    }
    func openGallery()
    {
        picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            self.present(picker, animated: true, completion: nil)
        }
        
    }
    func converToData(_ image:UIImage) -> Data{
        let imageData:NSData = UIImagePNGRepresentation(image)! as NSData
        return imageData as Data
    }
}

extension SignUpViwController : UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIPopoverControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let chosenImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            imageView_User.image =   chosenImage.resizeImageWith(newSize: CGSize(width:self.view.frame.size.width, height: 249))
    }
        dismiss(animated:true, completion: nil)
    }
    
    
    //What to do if the image picker cancels.
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
