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

import Foundation

#if os(iOS) || os(tvOS)
import UIKit
public typealias Image = UIImage
#else
import AppKit
public typealias Image = NSImage
#endif

class SwitchKitImageCache: NSCache<NSString, Image> {
    static var shared = SwitchKitImageCache()
}

class SwitchKitUIImageValue: Image, SwitchKitObserver {
    var switchKitKeyName: String?
    weak var switchKit: SwitchKit?
    weak var bound: NSObject?
    var block: ((Image?, NSObject, Error?) -> Void)?
    func bind<Type: NSObject>(_ object: Type, block: @escaping (Image?, Type, Error?) -> Void) {
        self.block = { image, bound, error in
            // swiftlint:disable:next force_cast
            block(image, bound as! Type, error)
        }
        self.bound = object
        objc_setAssociatedObject(object, &switchKitKeyName, self, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)

        switchKit?.addObserver(self)
        didUpdateSwitch(name: switchKitKeyName!)
    }
    func didUpdateSwitch(name: String) {
        if name == switchKitKeyName, let bound = self.bound {
            switchKit?.image(forKey: name) { image, error in
                self.block?(image, bound, error)
            }
        }
    }
}

extension SwitchKit {

    func image(forKey key: String, default defaultValue: Image? = nil) -> SwitchKitUIImageValue {
        let image = SwitchKitUIImageValue()
        image.switchKitKeyName = key
        image.switchKit = self
        return image
    }

    func image(forKey key: String,
               default defaultValue: Image? = nil,
               block: @escaping (Image?, Error?) -> Void) {

        guard let URLString = storage.value(forKey: key), let url = URL(string: URLString) else {
            block(defaultValue, NSError(domain: "io.github.switchkit", code: 5, userInfo: nil))
            return
        }

        if let cachedImage = SwitchKitImageCache.shared.object(forKey: NSString(string: URLString)) {
            block(cachedImage, nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = Image(data: data) {
                    SwitchKitImageCache.shared.setObject(downloadedImage, forKey: NSString(string: URLString))
                    block(downloadedImage, nil)
                } else {
                    block(defaultValue, error ?? NSError(domain: "io.github.switchkit", code: 6, userInfo: nil))
                }
            }
        }.resume()
    }
}
