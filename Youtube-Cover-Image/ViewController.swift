//
//  ViewController.swift
//  Youtube-Cover-Image
//
//  Created by Caner Çağrı on 5.07.2023.
//

import UIKit
import LinkPresentation
import MobileCoreServices

class ViewController: UIViewController {
    
    private let imageView: UIImageView = {
        var image = UIImageView()
        image.backgroundColor = .systemBackground
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        
        let url = URL(string: "https://www.youtube.com/watch?v=rWIPn3x31aM&t=1036s&ab_channel=Hozho")
        let metadataProvider: LPMetadataProvider = .init()
        
        metadataProvider.startFetchingMetadata(for: url!) { metadata, error in
            if let error = error {
                print(error)
                return
            }
            
            metadata?.imageProvider?.loadFileRepresentation(forTypeIdentifier: kUTTypeImage as String) { [weak self] url, imageProviderError in
                if let imageProviderError = imageProviderError {
                    print(imageProviderError)
                    return
                }
                
                guard let urlPath = url?.path, let image: UIImage = .init(contentsOfFile: urlPath) else { return }
                
                DispatchQueue.main.async {
                    self?.imageView.image = image
                }
               
            }
        }
    }
    
    private func setupLayout() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageView)
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 300).isActive = true
    }
}
