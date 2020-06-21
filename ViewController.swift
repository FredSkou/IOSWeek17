//
//  ViewController.swift
//  IOSWeek17
//
//  Created by admin on 19/06/2020.
//  Copyright © 2020 Fred. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    var imageList = [UIImage]()
    var imageNameList = [StorageReference]()
    var currentImage = -1


    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        // We declare the class the first responder.
        self.becomeFirstResponder()
        getImageFromDB()
        

// The Button is just for testing !!!!!
    }
    @IBAction func changePicture(_ sender: Any) {
       // setImage()
    }
    
    func setImage(){
        print("Setting Image!\(currentImage)")
        print(imageList.count)
        currentImage = currentImage + 1
        if currentImage >= imageList.count{
            currentImage = 0
            print("Current Image is 0")
        }
        print("OKWDOKWD \(currentImage)")
        image.image = imageList[currentImage]
    
    }
    
    // We override the function from the superclass so we can make it true.
    override func becomeFirstResponder() ->Bool{
        return true
    }
    // We set something to happen when the screen is shaken.
    func shake(motion: UIEvent.EventSubtype, withEvent event: UIEvent?){
        if(event?.subtype == UIEvent.EventSubtype.motionShake){
            setImage()
        }
    }
    func getImageFromDB(){
        print("Getting Images!")
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let downloadRef = storageRef.child("images")
        downloadRef.listAll(){(result,error) in
            if let error = error{
                print("No list all")
            }else{
                print("No Error")
            for prefix in result.prefixes{
                //print("Prefixes:")
                //var imageName = prefix
                //print(imageName)
                //self.imageNameList.append(imageName)
                //print(self.imageList.count)
            }

            for item in result.items{
                //print("Item Added to  list")
                //print(item)
                let imageName = item
                self.imageNameList.append(imageName)
                
                
                for item in self.imageNameList{
                    //let downloadRefItem = storageRef.child("\(item)")
                    let downloadTask = item.getData(maxSize: 1024*1024*1){data,error in
                    if let error = error {
                        print("Could Not Get Images: \(item)+ \(error)")
                    }
                    else{
                       // print("Downloading Images")
                        let image = UIImage(data: data!)
                        self.imageList.append(image!)
                        //print("Images Downloaded!")
                    }
                 }
                }
            }
                //print(self.imageNameList)
        }
    }
        
        
    }

}

