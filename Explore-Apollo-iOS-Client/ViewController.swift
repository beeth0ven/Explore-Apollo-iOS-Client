//
//  ViewController.swift
//  Explore-Apollo-iOS-Client
//
//  Created by luojie on 2018/3/11.
//  Copyright © 2018年 luojie. All rights reserved.
//

import UIKit
import Apollo
import Alamofire

class ViewController: UIViewController {

    let apollo = ApolloClient(url: URL(string: "https://home.beeth0ven.cf:3000/graphql")!)
    let imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
//        _ = apollo.watch(query: ArticleQuery()) { (result, error) in
//            guard error == nil else {
//                print("error: \(error!)")
//                return
//            }
//            print("result: \(result!)")
//        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let filename = "\(UUID().uuidString).jpg"
            Alamofire.request("http://home.beeth0ven.cf:3001/presignedURL?name=\(filename)")
                .responseJSON { (response) in
                    print("url response", response)
                    switch response.result {
                    case .success(let json):
                        if let url = (json as? [String: String])?["presignedURL"] {
                            let imageData = UIImageJPEGRepresentation(image, 0.5)!
                            Alamofire.upload(imageData, to: url, method: .put, headers: ["Content-Type":"image/jpeg"])
                                .uploadProgress(closure: { (progress) in
                                    print("progress", progress)
                                })
                                .response { response in
                                    print("upload response", response)
                            }
                        }
                    case .failure(let error):
                        break
                    }
                    
            }
        }
    }
}

