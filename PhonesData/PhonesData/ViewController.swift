//
//  ViewController.swift
//  PhonesData
//
//  Created by Apple on 25.11.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var table: UITableView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var models = [PhonesSpecificationsEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        table.delegate = self
        table.dataSource = self
        getAllItems()
    }

    @IBAction func didTapAddPhone(_ sender: UIBarButtonItem) {
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].brand
        cell.detailTextLabel?.text = models[indexPath.row].name
        return cell
    }
    
    func getAllItems() {
        do{
            models = try context.fetch(PhonesSpecificationsEntity.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        }catch {
            //error
        }
    }
}

