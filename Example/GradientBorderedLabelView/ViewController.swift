//
//  ViewController.swift
//  GradientBorderedLabelView
//
//  Created by mkeremkeskin on 11/27/2018.
//  Copyright (c) 2018 mkeremkeskin. All rights reserved.
//

import UIKit
import GradientBorderedLabelView

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        let gradientLabel = GradientBorderedLabelView(frame: CGRect(x: 20, y: 70, width: 160, height: 100))
        gradientLabel.textOfLabel = "Some gradient text from code with custom font"
        gradientLabel.fontSizeOfLabel = 22
        gradientLabel.customFontName = "Arial-ItalicMT"
        gradientLabel.labelBackgroundColor = UIColor.black

        self.view.addSubview(gradientLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

