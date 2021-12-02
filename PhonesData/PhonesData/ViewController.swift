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
        
        table.register(UINib(nibName: "XibTableViewCell", bundle: nil), forCellReuseIdentifier: "cellID")
        
        table.delegate = self
        table.dataSource = self
        getAllItems()
    }

    @IBAction func didTapAddPhone(_ sender: UIBarButtonItem) {
        guard let vc = storyboard?.instantiateViewController(identifier: "phoneVCID") as? PhoneViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Editing"
        vc.completion = { (status) in
            self.navigationController?.popToRootViewController(animated: true)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as! XibTableViewCell
        if let img = models[indexPath.row].photo{
            cell.imageIV.image = UIImage(data: img)
            cell.brandTF.text = models[indexPath.row].brand
            cell.nameTF.text = models[indexPath.row].name
            cell.osTF.text = models[indexPath.row].os
        }
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

