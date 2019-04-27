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

#if os(iOS) || os(tvOS)
import UIKit
#else
import AppKit
#endif

import Foundation

public class SwitchKit {
    let storage: SwitchKitStorage

    static var shared = SwitchKit(storage: SwitchKitStorageUserDefault())

    init(storage: SwitchKitStorage) {
        self.storage = storage
    }

    func color(forKey key: String, default defaultValue: Color? = nil) -> Color? {
        if let string = storage.value(forKey: key) {
            return Color.from(string: string)
        }
        return defaultValue
    }

    func url(forKey key: String, default defaultValue: URL? = nil) -> URL? {
        if let string = storage.value(forKey: key) {
            return URL(string: string)
        }
        return defaultValue
    }

    func value(_ name: String) -> Bool {
        return value(name, default: false)
    }

    func value<Type>(_ name: String, default defaultValue: Type) -> Type {
        guard let value = storage.value(forKey: name) else {
            return defaultValue
        }

        switch defaultValue {
        case _ as Color:
            return Color.from(string: value) as! Type
        case _ as Bool:
            return !(value.isEmpty) as! Type
        case _ as String:
            return value as! Type
        default: return defaultValue
        }
    }

    var delegates: [WeakRef<AnyObject>] = []

    func addObserver(_ observer: SwitchKitObserver) {
        delegates.append(WeakRef(observer))
    }

    func setValues(fromDict registrationDictionary: [String : Any], path: String? = nil) {
        for key in registrationDictionary.keys {
            let keyPath = (path?.appending(".") ?? "").appending(key)
            if let value = registrationDictionary[key] as? String {
                setValue(value, forKey: keyPath)
            }
            if let dict = registrationDictionary[key] as? [String : Any] {
                setValues(fromDict: dict, path: keyPath)
            }
        }
    }

    func setValue(_ value: String?, forKey key: String) {
        storage.setValue(value, forKey: key)
        for delegate in delegates {
            if let delegate = delegate.value as? SwitchKitObserver {
                DispatchQueue.main.async {
                    delegate.didUpdateSwitch(name: key)
                }
            }
        }
    }
}


protocol SwitchKitObserver: AnyObject {
    func didUpdateSwitch(name: String)
}

class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?
    init(_ value: T?) {
        self.value = value
    }
}

