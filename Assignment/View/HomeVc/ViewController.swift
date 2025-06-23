//
//  ViewController.swift
//  Assignment
//
//  Created by Bhagyadhar Sahoo on 21/06/25.
//

import UIKit
import GoogleSignIn

final class ViewController: UIViewController {
    
    private let viewModel = AuthViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if viewModel.isUserSavedInCoreData(){
            navigatetoAllMenu()
        }
    }

    @IBAction func tapOnlogOut(_ sender: UIButton) {
        
    }
    
    @IBAction func tapOnLogin(_ sender: UIButton) {
        viewModel.signInWithGoogle(presentingVC: self) { [weak self] success in
               guard let self else {return}
                    if success {
                        navigatetoAllMenu()
                        print("🎉 Signed in and saved to Core Data")
                        // Navigate to home screen or show UI update
                    } else {
                        print("❌ Sign-in failed")
                    }
                }
    }
    
    private func navigatetoAllMenu() {
        DispatchQueue.main.async {
            let vc = AllMenuVc()
            vc.navigationController?.setNavigationBarHidden(true, animated: false)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

