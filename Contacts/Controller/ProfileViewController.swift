//
//  ProfileViewController.swift
//  Contacts
//
//  Created by 登秝吳 on 26/04/2020.
//  Copyright © 2020 登秝吳. All rights reserved.
//

import UIKit
import Kingfisher

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var marketingLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var lastUpdatedLabel: UILabel!
    
    let viewModel: ContactViewModel
    
    init(_ viewModel: ContactViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        contactImage.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(named: "avatar"))
        nameLabel.text = viewModel.fullNameWithTitle
        addressLabel.text = viewModel.address
        phoneLabel.text = viewModel.phoneNumber
        emailLabel.text = viewModel.email
        marketingLabel.text = "Marketing? \(viewModel.marketing ? "✅" : "❌")"
        creationDateLabel.text = "Created: " + viewModel.creationFormattedString
        lastUpdatedLabel.text = "Updated: " +  viewModel.updatedFormattedString
        
        contactImage.isUserInteractionEnabled = true
        let touch = UITapGestureRecognizer(target: self, action: #selector(addUserImage))
        contactImage.addGestureRecognizer(touch)
    }



    @objc func addUserImage() {
        let alertController = UIAlertController(title: "Change Image", message: nil, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let updateAction = UIAlertAction(title: "Change", style: .default) { [unowned self] _ in
            self.viewModel.generateImageURL()
            self.contactImage.kf.setImage(with: self.viewModel.imageURL, placeholder: UIImage(named: "avatar"))
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(updateAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
