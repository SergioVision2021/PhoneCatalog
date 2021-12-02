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
        
        if models.isEmpty {
            testData()
        }
        
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

//Mark: - Extension ViewController

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

extension ViewController {
    func testData(){
        
        var testphone: PhonesSpecificationsEntity?
        
        testphone = PhonesSpecificationsEntity(context: ViewController().context)
        testphone?.brand = "HONOR"
        testphone?.model = "50"
        testphone?.name = "8GB/256GB"
        testphone?.display = "6.57"
        testphone?.os = "Android 11"
        testphone?.photo = UIImage(named: "phone1")?.pngData()
        testphone?.cpu = "Qualcomm Snapdragon 778G"
        testphone?.gpu = "Adreno 642L"
        testphone?.camera = "100"
        testphone?.ram = "6"
        testphone?.storage = "256"
        testphone?.release_date = Date()
        testphone?.battery = "5000"
        
        createUpdateItem(status: true)
        
        testphone = PhonesSpecificationsEntity(context: ViewController().context)
        testphone?.brand = "Samsung"
        testphone?.model = "S8"
        testphone?.name = "4GB/256GB"
        testphone?.display = "6"
        testphone?.os = "Android 10"
        testphone?.photo = UIImage(named: "phone2")?.pngData()
        testphone?.cpu = "Qualcomm Snapdragon 33G"
        testphone?.gpu = "Adreno 650L"
        testphone?.camera = "18"
        testphone?.ram = "8"
        testphone?.storage = "64"
        testphone?.release_date = Date()
        testphone?.battery = "4500"
        
        createUpdateItem(status: true)
        
        testphone = PhonesSpecificationsEntity(context: ViewController().context)
        testphone?.brand = "Huawei"
        testphone?.model = "nova 8i"
        testphone?.name = "NEN-L22 6GB/128GB"
        testphone?.display = "6.67"
        testphone?.os = "Android 10"
        testphone?.photo = UIImage(named: "phone3")?.pngData()
        testphone?.cpu = "Qualcomm Snapdragon 662"
        testphone?.gpu = "Adreno 610"
        testphone?.camera = "64"
        testphone?.ram = "6"
        testphone?.storage = "128"
        testphone?.release_date = Date()
        testphone?.battery = "4300"
        
        createUpdateItem(status: true)
        
        testphone = PhonesSpecificationsEntity(context: ViewController().context)
        testphone?.brand = "Apple"
        testphone?.model = "iPhone 13"
        testphone?.name = "128GB"
        testphone?.display = "6.1 Oled"
        testphone?.os = "iOS 15"
        testphone?.photo = UIImage(named: "phone4")?.pngData()
        testphone?.cpu = "Apple A15 Bionic"
        testphone?.gpu = "A15"
        testphone?.camera = "12"
        testphone?.ram = "4"
        testphone?.storage = "128"
        testphone?.release_date = Date()
        testphone?.battery = "4600"
        
        createUpdateItem(status: true)
    }
}

