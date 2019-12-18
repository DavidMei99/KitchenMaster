//
//  viewPage.swift
//  Kitchen-Master
//
//  Created by Zhihao Wang on 12/15/19.
//  Copyright © 2019 Zhihao Wang. All rights reserved.
//

import UIKit

class viewPage: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var ingredLabel: UILabel!
    
    @IBOutlet weak var insLabel: UILabel!
    
    var displayRecipe:[Recipe] = []
    
    var titletext:String?
    var ingredtext:String?
    var instext:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titletext
        ingredLabel.text = ingredtext
        insLabel.text = instext
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
