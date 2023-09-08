//
//  ViewController.swift
//  Flower Identifier
//
//  Created by Eric Huang on 8/5/20.
//  Copyright © 2020 Eric Huang. All rights reserved.
//

import UIKit
import CoreML
import Vision
import SDWebImage

class ViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var bodyText: UILabel!
    
    var pickedImage:UIImage?
    
    let imagePicker = UIImagePickerController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bodyText.adjustsFontSizeToFitWidth = true
        bodyText.minimumScaleFactor = 0.5
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .camera
        
    }

    @IBAction func camera(_ sender: UIBarButtonItem) {

        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func detect(image:CIImage){
        
        guard let model = try? VNCoreMLModel(for: FlowerClassifier().model) else {
                   
            fatalError("Loading model failed.")
                   
        }
               
        let requests = VNCoreMLRequest(model: model, completionHandler: { (request, error) in
                   
            guard let results = request.results as? [VNClassificationObservation] else {
                       
                fatalError("Model failed processing image.")
                       
            }
            
            let flowerName = results.first?.identifier
            
            if let result = self.fetchResult(setURLString: self.fetchURL(flowerName: flowerName!, isImage: false)){
                self.titleText.text = result.title
                self.bodyText.text = result.extract
                
            }
            if let image = self.fetchImage(setURLString: self.fetchURL(flowerName: flowerName!, isImage: true)){
                self.imageView.sd_setImage(with:URL(string: image.source) ) { (image, error, cache, url) in
                    
                    if self.imageView.image == nil{
                        self.imageView.image = self.pickedImage
                    }
                }
            }
        })
               
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
            try handler.perform([requests])
        }catch{
            print(error)
        }
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            pickedImage = userPickedImage
            
            guard let ciImage = CIImage(image: userPickedImage) else {
                fatalError("Error while transferring image type to ciimage.")
            }
            detect(image: ciImage)

        }
        
        dismiss(animated: true, completion: nil)
    }
    func fetchURL(flowerName:String, isImage:Bool)->String{
        let initialURL = "https://en.wikipedia.org/w/api.php"
        
        let flowerHashName = flowerName.replacingOccurrences(of: " ", with: "%20")
        
        var urlString = "\(initialURL)?format=json&action=query&prop=extracts&exintro=&explaintext=&titles=\(flowerHashName)&indexpageids&redirects=1"
        
        if isImage{
            
            urlString = "\(initialURL)?action=query&titles=\(flowerHashName)&prop=pageimages&format=json&pithumbsize=500"
            
        }
        
        
        return urlString
    }
   
    func fetchResult(setURLString:String)->Results?{
        
        print(setURLString)
        if let URL = URL(string: setURLString){
            
            var finalResult:Results?
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: URL) { (data, response, error) in
                
                if error != nil{
                    print(error!)
                    return
                }
                
                if let safeData = data{
                    
                    let decoder = JSONDecoder()
                    do{
                        let decodedResponse = try decoder.decode(WikiData.self, from: safeData).query.pages
                                                   
                        if let pageid = decodedResponse.first?.key{
                            finalResult = decodedResponse[pageid]
                        }
                        
                    }catch{
                        print(error)
                    }
                    
                }
              
            }
            task.resume()
            sleep(5)
            return finalResult
        }else{
            return nil
        }
        
    }
    
    func fetchImage(setURLString:String)->Thumbnail?{
         
         
         if let URL = URL(string: setURLString){
             
             var finalResult:Thumbnail?
             
             let session = URLSession(configuration: .default)
             
             let task = session.dataTask(with: URL) { (data, response, error) in
                 
                 if error != nil{
                     print(error!)
                     return
                 }
                 
                 if let safeData = data{
                     
                     let decoder = JSONDecoder()
                     do{
                        let decodedResponse = try decoder.decode(WikiImage.self, from: safeData).query.pages
                        
                        if let pageid = decodedResponse.first?.key{
                            finalResult = decodedResponse[pageid]?.thumbnail
                        }
                     }catch{
                         print(error)
                     }
                     
                 }
               
             }
             task.resume()
             sleep(5)
             return (finalResult)
         }else{
             return nil
         }
         
     }
}

struct WikiData: Codable {
    
    struct Query: Codable {
        let pages: [String:Results]
    }
    let query: Query
}

struct Results:Codable{
    let pageid:Int
    let title:String
    let extract:String
}

 struct Thumbnail: Codable {
     let source:String
     let width:Int
     let height:Int
 }
struct WikiImage:Codable{
    struct ImageSource:Codable{
        let pageid:Int
        let title:String
        
        let thumbnail:Thumbnail
    }
    struct Query: Codable {
        let pages: [String:ImageSource]
    }
    let query:Query
}

