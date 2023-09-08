//
//  ViewController.swift
//  SeeFood
//
//  Created by Eric Huang on 8/3/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            imageView.image = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else{
                fatalError("Cannot cast picked image into a CIImage.")
            }
            
            detect(image: ciImage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
        
    }
    
    func detect(image:CIImage){
        
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else{
            
            fatalError("Loading CoreML failed.")
            
        }
        
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                
                fatalError("Model failed processing image.")
                
            }
            self.navigationItem.title = results.first?.identifier
//            if let firstResult = results.first{
//                if firstResult.identifier.contains("Human"){
//
//                    self.navigationItem.title = "Human"
//
//                }else{
//
//                    self.navigationItem.title = "Not Human"
//
//                }
//            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
           
            try handler.perform([request])
            
        }catch{
            print(error)
        }
        
    }
    
    @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    
    
}

