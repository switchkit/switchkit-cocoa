//
//  SwitchKit
//
//  Copyright (c) 2019-Present SwitchKit Team - https://github.com/SwitchKit
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import SwitchKit
import UIKit

class ViewController: UIViewController {
    override func viewDidLoad() {

        SwitchKit.shared.setValues(fromDict: [
            "bgColor": "#cdedfc",
            "switchkit-logo": "https://avatars0.githubusercontent.com/u/49499165?s=200&v=4"
        ])

        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = SwitchKit.shared.value("bgColor", default: UIColor.white)

        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.frame = CGRect(origin: .zero,
                                 size: CGSize(width: 100, height: 100))

        SwitchKit.shared.image(forKey: "switchkit-logo") { [weak imageView] img, error in
            if error == nil {
                imageView?.image = img
            }
        }
    }
}
