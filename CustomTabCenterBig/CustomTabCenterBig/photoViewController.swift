//
//  photoViewController.swift
//  CustomTabCenterBig
//
//  Created by Xibo Zhang on 17/4/25.
//  Copyright © 2017年 Nitin Gohel. All rights reserved.
//

import UIKit
import CoreML
import Alamofire

@available(iOS 11.0, *)

class photoViewController:  UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    @IBOutlet weak var myLabel_: UILabel!    //var model: Inceptionv3!
    let model = Inceptionv3()
    let model_ = Inceptionv3_new()
    
    
    
    @IBAction func uploadButtonTapped(sender: AnyObject) {
        
        print("################################")
        let urlString = URL(string: "https://jsonplaceholder.typicode.com/users/1")
        if let url = urlString {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    print(error)
                } else {
                    if let usableData = data {
                        print("here it is")
                        print(usableData) //JSONSerialization
                    }
                }
            }
            task.resume()
        }
        //myImageUploadRequest1()
        
    }
    
    @IBAction func selectPhotoButtonTapped(sender: AnyObject) {
/*
        let pick:UIImagePickerController = UIImagePickerController()
        pick.delegate = self
        pick.sourceType = UIImagePickerControllerSourceType.photoLibrary
        self.present(pick, animated: true, completion: nil)
*/
        
        let myPickerController:UIImagePickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerControllerSourceType.photoLibrary
        
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    
    /*
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
        
    {
        myImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        self.dismiss(animated: true, completion: nil)
        
    }
 */
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            return
        }

        //myImageView.image = image

        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 299, height: 299), true, 2.0)
        image.draw(in: CGRect(x: 0, y: 0, width: 299, height: 299))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
        var pixelBuffer : CVPixelBuffer?
        let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(newImage.size.width), Int(newImage.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
        guard (status == kCVReturnSuccess) else {
            return
        }
        
        CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)
        
        let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGContext(data: pixelData, width: Int(newImage.size.width), height: Int(newImage.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue) //3
        
        context?.translateBy(x: 0, y: newImage.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        UIGraphicsPushContext(context!)
        newImage.draw(in: CGRect(x: 0, y: 0, width: newImage.size.width, height: newImage.size.height))
        UIGraphicsPopContext()
        CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
        myImageView.image = newImage
        
        guard let prediction = try? model.prediction(image: pixelBuffer!) else {
            return
        }
        
        guard let prediction_ = try? model_.prediction(image: pixelBuffer!) else {
            return
        }
        myLabel.numberOfLines = 0;
        myLabel.text = "I think this is a \(prediction.classLabel)."
        //myLabel_.numberOfLines = 0;
        //myLabel_.text = "\(prediction_.flatten_output[2047])."
        myLabel_.numberOfLines = prediction_.flatten_output.count
        
        for i in 1 ... myLabel_.numberOfLines{
            myLabel_.text = "this\(prediction_.flatten_output[i])."
        }
        
        for i in 1 ... 2048{
            print(prediction_.flatten_output[i])
        }
        // 收回图库选择界面
        self.dismiss(animated: true, completion: nil)
    }

    
    var jsonArray:NSMutableArray?
    var newArray: Array<String> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //myImageUploadRequest()
            Alamofire.request("https://www.appcoda.com/alamofire-beginner-guide/",method: .get) .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                self.parseData(JSONData: response.data!)


        }
    }
    
    func parseData(JSONData: Data) {
        
        do {
            let readableJSON = try JSONSerialization.jsonObject(with: JSONData, options:.mutableContainers) as! [String: Any]
            print(readableJSON)
        }
        catch {
            print(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func myImageUploadRequest1()
    {
        let myUrl = URL(string: "http://192.168.1.3/testIOS.php");
        
        var request = URLRequest(url:myUrl!)
        
        request.httpMethod = "POST"// Compose a query string
        //request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        let postString = "firstName=happy&lastName=apache";
        
        request.httpBody = postString.data(using: String.Encoding.utf8);
        
        let task = URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error != nil
            {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("response = \(response)")
                    //Let's convert response sent from a server side script to a NSDictionary object:
            do {
                
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? NSDictionary
                print("============================")
                if let parseJSON = json {
                    
                    // Now we can access value of First Name by its key
                    let firstNameValue = parseJSON["firstName"] as? String
                    print("firstNameValue: \(firstNameValue)")
                    self.myLabel_.text = firstNameValue
                }
            } catch {
                print(error)
            }
 
        }
        task.resume()
        
    }
    
    /*
    func myImageUploadRequest2()
    {
        
        let myUrl = NSURL(string: "http://192.168.1.3/testIOS.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
            "firstName"  : "Sergey",
            "lastName"    : "Kargopolov",
            "userId"    : "9"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        //let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        //if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters2(parameters: param, filePathKey: "file", boundary: boundary) as Data
        
        print("##############################################################")
        let mystring = NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)
        print(mystring )
        
        
        myActivityIndicator.startAnimating();
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                //let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                //print(json)
                
                DispatchQueue.main.async(execute: {
                    self.myActivityIndicator.stopAnimating()
                    self.myImageView.image = nil;
                });
                
            }
            catch
            {
                print("%%%%%%%%%%%%%%%%%%%%%%%%%%%")
                print(error)
            }
            
        }
        
        task.resume()

    }
    */
    /*
    func createBodyWithParameters2(parameters: [String: String]?, filePathKey: String?, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        /*
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        //body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        */
        return body
    }

    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
     */
/*
    func myImageUploadRequest()
    {
        
        let myUrl = NSURL(string: "http://192.168.1.3/testIOS.php");
        //let myUrl = NSURL(string: "http://www.boredwear.com/utils/postImage.php");
        
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        let param = [
            "firstName"  : "king",
            "lastName"    : "leo",
            "userId"    : "7"
        ]
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = UIImageJPEGRepresentation(myImageView.image!, 1)
        
        if(imageData==nil)  { return; }
        
        request.httpBody = createBodyWithParameters3(parameters: param, filePathKey: "file", imageDataKey: imageData! as NSData, boundary: boundary) as Data
        
        print("##############################################################")
        print(request.httpBody)
        print("##############################################################")
        let mystring = NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)
        print(mystring )
        
         myActivityIndicator.startAnimating();
         
         let task = URLSession.shared.dataTask(with: request as URLRequest) {
                data, response, error in
         
         if error != nil {
                print("error=\(error)")
                return
         }
         
         // You can print out response object
         print("******* response = \(response)")
         
         // Print out reponse body
         let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
         print("****** response data = \(responseString!)")
         
         do {
            let json = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
         
            print(json)
         
            DispatchQueue.main.async(execute: {
                    self.myActivityIndicator.stopAnimating()
                    self.myImageView.image = nil;
            });
         
         }catch
         {
            print("###########################")
            print(error)
         }
         
         }
         
         task.resume()
        
    }
    */
    /*
    func createBodyWithParameters3(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData();
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        let mimetype = "image/jpg"
        
        body.appendString(string: "--\(boundary)\r\n")
        body.appendString(string: "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
        body.append(imageDataKey as Data)
        body.appendString(string: "\r\n")
        
        
        
        body.appendString(string: "--\(boundary)--\r\n")
        
        return body
    }
*/
    
}
/*
extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
*/
