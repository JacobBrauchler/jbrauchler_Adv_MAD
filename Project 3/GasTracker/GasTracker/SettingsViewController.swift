//
//  SettingsViewController.swift
//  GasTracker
//
//  Created by Jacob Brauchler on 5/1/17.
//  Copyright © 2017 JBrauchler. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController
{
    private let signOutSegue = "userPressedSignOutWithSegue"
    private let signOutSegueIfFailed = "goToSignIn"
    private func signOut() {
        Backendless.sharedInstance().userService.logout()
        performSegue(withIdentifier: signOutSegue, sender: self)
        if navigationController?.visibleViewController == self {
            performSegue(withIdentifier: signOutSegueIfFailed, sender: self)
        }
    }
    @IBAction func userHitSignOut(_ sender: Any) {
        signOut()
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 { //clicked sign out row instead of button accident
            signOut()
        }
    }
}
