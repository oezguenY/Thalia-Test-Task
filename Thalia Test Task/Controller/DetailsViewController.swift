//
//  DetailsViewController.swift
//  Thalia Test Task
//
//  Created by Özgün Yildiz on 13.06.21.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var bodyLbl: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    
    var message: Message!
    var passedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = message.title
        bodyLbl.text = message.body
        bookImage.image = passedImage
        title = "Details"
    }
    


}
