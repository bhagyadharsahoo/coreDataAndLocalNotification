//
//  AllMenuVc.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 22/06/25.
//

import UIKit

final class AllMenuVc: UIViewController {
    let viewModel = AuthViewModel()
    
    @IBOutlet weak var switchView: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchView.isOn = CoreDataManager.shared.notificationsEnabled
        self.navigationItem.backBarButtonItem?.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationItem.backBarButtonItem?.isHidden = true
        
    }

    @IBAction func pdfViewrClicked(_ sender: UIButton) {
        let vc = PdfReaderVc()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func imageViewerClicked(_ sender: UIButton) {
        let vc = ImageVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func listClickedClicked(_ sender: UIButton) {
        let vc = DataListNewVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func toggleNotifications(_ sender: UISwitch) {
           CoreDataManager.shared.notificationsEnabled = sender.isOn
    }
    
    @IBAction func signOutClicked(_ sender: UIButton) {
        viewModel.logOut()
        self.navigationController?.popToRootViewController(animated: true)
    }
}
