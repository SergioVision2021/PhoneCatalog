//
//  PhoneViewController.swift
//  PhonesData
//
//  Created by Apple on 1.12.21.
//

import UIKit

class PhoneViewController: UIViewController {

    @IBOutlet weak var operationsSC: UISegmentedControl!
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
    @IBOutlet weak var battaryTF: UITextField!
    @IBOutlet weak var dateReleaseDP: UIDatePicker!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTapSave))
        navigationItem.rightBarButtonItem?.isEnabled = false
        
    }
    
    // MARK: - Navigation
    
    @objc func didTapSave() {
    }
    


}
