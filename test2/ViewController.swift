//
//  ViewController.swift
//  test2
//
//  Created by Alex on 11/7/16.
//  Copyright © 2016 Alex. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var style = 0
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }

    @IBAction func doTest(_ sender: UIButton) {
        
        
        let vc = storyboard!.instantiateViewController(withIdentifier: "popup") as? PopupViewController
           vc?.modalTransitionStyle = .coverVertical
        vc?.modalPresentationStyle = .custom
         vc?.transitioningDelegate = self
     
        present(vc!, animated: true, completion: nil)
    }

    
    
    @IBAction func showPopover(_ sender: UIButton) {
         let vc = storyboard!.instantiateViewController(withIdentifier: "popup") as? PopupViewController
         vc?.modalPresentationStyle = .popover
         vc?.popoverPresentationController?.sourceRect = sender.bounds
         vc?.popoverPresentationController?.sourceView = sender
         vc?.popoverPresentationController?.delegate = self
         vc?.popoverPresentationController?.permittedArrowDirections = .up
         vc?.popoverPresentationController?.backgroundColor = UIColor.red
 
        present(vc!, animated: true, completion: nil)
    }
   
    

}

extension  ViewController:UIPopoverPresentationControllerDelegate  {

    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none

    }
}

extension ViewController:UIViewControllerTransitioningDelegate   {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return HalfModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}



