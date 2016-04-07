//
//  AnimationViewController.swift
//  SampleTable
//
//  Created by babykang on 16/4/7.
//  Copyright © 2016年 babykang. All rights reserved.
//

import UIKit

class AnimationViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    
    @IBOutlet var dialogView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        /* 背景虚化 */
        
        let blurEffect = UIBlurEffect(style:.Dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        /* animation */
        dialogView.transform = CGAffineTransformMakeScale(0.0, 0.0)
    }

    override func viewDidAppear(animated: Bool) {
//        UIView.animateWithDuration(0.7, delay: 0.0, options: [], animations: {
//            self.dialogView.transform = CGAffineTransformMakeScale(1.1, 1.1)}, completion: nil)
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: [], animations: {
                self.dialogView.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
