//
//  MessageViewController.swift
//  Thalia Test Task
//
//  Created by Özgün Yildiz on 13.06.21.
//

import UIKit

class MessageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    var messages: [Message] = [Message]()
    var imageToPass: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: messagesTableViewCell, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: messagesTableViewCell)
        tableView.delegate = self
        tableView.dataSource = self
        self.getUrlSession()
        tableView.tableFooterView = UIView()
        title = "Inbox"
    }
    
    func getUrlSession() {
        
        guard let url = URL(string: URL_BASE) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard error == nil else {
                debugPrint(error.debugDescription)
                return
            }
            
            guard let data = data else { return }
            print(data)
            do {
                let downloadedMessages = try JSONDecoder().decode([Message].self, from: data)
                print(downloadedMessages[0].imageUrl)
                self.messages = downloadedMessages
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch {
                debugPrint(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: messagesTableViewCell, for: indexPath) as? MessagesTableViewCell else { return UITableViewCell() }
        cell.titleLbl.text = messages[indexPath.row].title
        cell.bodyLbl.text = messages[indexPath.row].body
        
        if let imageURL = URL(string: self.messages[indexPath.row].imageUrl) {
            let data = try? Data(contentsOf: imageURL)
            if let data = data {
                let image = UIImage(data: data)
                self.imageToPass = image
                DispatchQueue.main.async {
                    cell.bookImage.image = image
                }
                
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = messages[indexPath.row]
        performSegue(withIdentifier: toDetailSegue, sender: selectedItem)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == toDetailSegue {
            guard let destinationVC = segue.destination as? DetailsViewController else { return }
            guard let message = sender as? Message else { return }
            destinationVC.message = message
            destinationVC.passedImage = self.imageToPass
        }
    }
    
    // MARK: - ALTERNATIVELY, WE CAN PASS DATA THIS WAY
    
    // This would obviate the need for the "didSelectRowAt" and "prepare for segue" functions. Also, we would have to delete the segue between the MessageViewController and the DetailsViewController, if we want to pass data with the "didSelectRowAt" function. In this case, the DetailsViewController will need a Storyboard Identifier.
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let message = messages[indexPath.row]
//        guard let cell = tableView.cellForRow(at: indexPath) as? MessagesTableViewCell else { return }
//        guard let dvc = storyboard?.instantiateViewController(identifier: "DetailVCStoryboardID") as? DetailsViewController else { return }
//        guard let image = cell.bookImage?.image else { return }
//        dvc.passedImage = image
//        dvc.message = message
//        self.show(dvc, sender: nil)
//    }

}
