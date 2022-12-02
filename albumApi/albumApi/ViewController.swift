//
//  ViewController.swift
//  albumApi
//
//  Created by Mac on 30/11/22.
//

import UIKit


struct Album : Decodable {
    let userId, id: Int
    let title: String
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var alumTable: UITableView!
    var albumArray: [Album] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        albumApi()
    }
    
    
    func albumApi() {
        let str = "https://jsonplaceholder.typicode.com/albums"
        let url = URL(string: str)
        
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if error == nil {
                do {
                    self.albumArray =  try JSONDecoder().decode([Album].self, from: data!)
                    DispatchQueue.main.async {
                        self.alumTable.reloadData()
                    }
                } catch {
                    print("Something went wrong!")
                }
            }
        }.resume()
    }


}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albumArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! AlbumTableViewCell
        let album = albumArray[indexPath.row]
        cell.userLabel.text = String("UserId : \(album.userId)")
        cell.idLabel.text = String("Id : \(album.id)")
        cell.titleLabel.text = String("Title : \(album.title)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180.0
    }
}
