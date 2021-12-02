//
//  PhoneViewController.swift
//  PhonesData
//
//  Created by Apple on 1.12.21.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var operationsSC: UISegmentedControl!
    @IBOutlet weak var downloadPhotoBt: UIButton!
    @IBOutlet weak var photoIV: UIImageView!
    @IBOutlet weak var brandTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var modelTF: UITextField!
    @IBOutlet weak var displayTF: UITextField!
    @IBOutlet weak var cpuTF: UITextField!
    @IBOutlet weak var gpuTF: UITextField!
    @IBOutlet weak var cameraTF: UITextField!
    @IBOutlet weak var osTF: UITextField!
    @IBOutlet weak var ramTF: UITextField!
    @IBOutlet weak var storageTF: UITextField!
    @IBOutlet weak var batteryTF: UITextField!
    @IBOutlet weak var dateReleaseDP: UIDatePicker!
    
    //<- output data DetailEditViewController
    public var completion: ((Bool) -> Void)?
    
    //ViewController input data->
    public var currentDataPhone: PhonesSpecificationsEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        switch self.title {
        case "Additing":
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(didTapAdd))
            operationsSC.isHidden = true
            styleElements(state: true)
            
        case "Editing":
            navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                                style: .done,
                                                                target: self,
                                                                action: #selector(didTapSave))
            navigationItem.rightBarButtonItem?.isEnabled = false
            
            loadContent()
        default:
            break
        }
        
    }
    
    // MARK: - Navigation
    
    @objc func didTapSave() {
        completion?(true)
    }
    
    @objc func didTapAdd() {
        completion?(true)
    }
    

    @IBAction func didTapOperationsSC(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            styleElements(state: false)
        case 1:
            styleElements(state: true)
        default:
            break
        }
    }
    
    
    
    func styleElements(state: Bool){
        navigationItem.rightBarButtonItem?.isEnabled = state
        
        downloadPhotoBt.isHidden = !state
        
        nameTF.isEnabled = state
        brandTF.isEnabled = state
        modelTF.isEnabled = state
        displayTF.isEnabled = state
        cpuTF.isEnabled = state
        gpuTF.isEnabled = state
        cameraTF.isEnabled = state
        osTF.isEnabled = state
        ramTF.isEnabled = state
        storageTF.isEnabled = state
        batteryTF.isEnabled = state
        dateReleaseDP.isEnabled = state
    }
    
    func loadContent() {
        if let img = currentDataPhone?.photo,
           let releaseDate = currentDataPhone?.release_date{
            
            let image = UIImage(data: img)
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YY/NN/dd"
            dateFormatter.string(from: releaseDate)
            
            photoIV.image = image
            nameTF.text = currentDataPhone?.name
            brandTF.text = currentDataPhone?.brand
            modelTF.text = currentDataPhone?.model
            displayTF.text = currentDataPhone?.display
            cpuTF.text = currentDataPhone?.cpu
            gpuTF.text = currentDataPhone?.gpu
            cameraTF.text = currentDataPhone?.camera
            osTF.text = currentDataPhone?.os
            ramTF.text = currentDataPhone?.ram
            storageTF.text = currentDataPhone?.storage
            batteryTF.text = currentDataPhone?.battery
            dateReleaseDP.date = releaseDate
        }
    }
}
