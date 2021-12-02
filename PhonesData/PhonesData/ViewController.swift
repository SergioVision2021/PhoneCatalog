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
        vc.title = "Additing"
        vc.completion = { (status) in
            self.navigationController?.popToRootViewController(animated: true)
            self.createUpdateItem(status: status)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let vc = storyboard?.instantiateViewController(identifier: "phoneVCID") as? PhoneViewController else { return }
        vc.navigationItem.largeTitleDisplayMode = .never
        vc.title = "Editing"
        vc.currentDataPhone = models[indexPath.row]
        
        vc.completion = { (status) in
            self.navigationController?.popToRootViewController(animated: true)
            self.createUpdateItem(status: status)
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            deleteItem(item: models[indexPath.row])
            createUpdateItem(status: true)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
    
    func deleteItem(item: PhonesSpecificationsEntity){
        context.delete(item)
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
    
    func createUpdateItem(status: Bool) {
        if status {
            saveItem()
            getAllItems()
        }
    }
    
    func saveItem(){
        do{
            try context.save()
        }catch{
            //error
        }
    }
}

