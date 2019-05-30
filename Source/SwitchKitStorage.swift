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

public protocol SwitchKitStorage {
    func setValue(_ value: String?, forKey key: String)
    func setValues(_ values: [String: String?])
    func value(forKey key: String) -> String?
}

public class SwitchKitStorageUserDefaults: SwitchKitStorage {
    let suiteName = "io.github.switchkit"
    let userDefaults: UserDefaults

    public init() {
        userDefaults = UserDefaults(suiteName: suiteName)!
    }

    public func setValue(_ value: String?, forKey key: String) {
        userDefaults.setValue(value, forKey: key)
        userDefaults.synchronize()
    }

    public func setValues(_ values: [String: String?]) {
        values.forEach { key, value in
            userDefaults.setValue(value, forKey: key)
        }
        userDefaults.synchronize()
    }

    public func value(forKey key: String) -> String? {
        return userDefaults.string(forKey: key)
    }
}

public class SwitchKitStorageMemory: SwitchKitStorage {

    private(set) var data: [String: String] = [:]

    public func setValue(_ value: String?, forKey key: String) {
        if let value = value {
            data.updateValue(value, forKey: key)
        } else {
            data.removeValue(forKey: key)
        }
    }

    public func setValues(_ values: [String: String?]) {
        values.keys.forEach { key in
            if let value = values[key] as? String {
                data.updateValue(value, forKey: key)
            } else {
                data.removeValue(forKey: key)
            }
        }
    }

    public func value(forKey key: String) -> String? {
        return data[key]
    }

}
