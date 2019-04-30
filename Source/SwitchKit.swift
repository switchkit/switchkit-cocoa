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

    static var shared = SwitchKit(storage: SwitchKitStorageUserDefaults())

    /// Designated initializer.
    ///
    /// - Parameter storage: SwitchKitStorage instance used to read or write SwitchKit values.
    init(storage: SwitchKitStorage) {
        self.storage = storage
    }

    // MARK: -

    func color(forKey key: String, default defaultValue: Color? = nil) -> Color? {
        if let string = storage.value(forKey: key) {
            return Color.from(string: string)
        }
        return defaultValue
    }

    func url(forKey key: String, default defaultValue: URL? = nil) -> URL? {
        if let string = storage.value(forKey: key) {
            return URL(string: string) ?? defaultValue
        }
        return defaultValue
    }

    func bool(forKey key: String, default defaultValue: Bool = false) -> Bool {
        if let string = storage.value(forKey: key) {
            return !(string.isEmpty)
        }
        return defaultValue
    }

    func string(forKey key: String, default defaultValue: String? = nil) -> String? {
        return storage.value(forKey: key) ?? defaultValue
    }

    func int(forKey key: String, default defaultValue: Int? = nil) -> Int? {
        guard let value = storage.value(forKey: key) else {
            return defaultValue
        }

        if let int = Int(value) { return int }
        if let double = Double(value) { return Int(double) }

        return defaultValue
    }

    func double(forKey key: String, default defaultValue: Double? = nil) -> Double? {
        return Double(storage.value(forKey: key) ?? "") ?? defaultValue
    }

    func float(forKey key: String, default defaultValue: Float? = nil) -> Float? {
        return Float(storage.value(forKey: key) ?? "") ?? defaultValue
    }

    // MARK: -

    /// Let a SwitchKit value act as a boolean, if value isn't set or is empty,
    /// the method return false
    ///
    /// - Parameters:
    ///   - key: SwitchKit key name
    /// - Returns: true if a value is set and is not empty.
    func value(_ key: String) -> Bool {
        return value(key, default: false)
    }

    func value<Type>(_ key: String, default defaultValue: Type) -> Type {

        var value: Any?

        switch defaultValue {
        case _ as Color:
            value = self.double(forKey: key)

        case let defaultValue as Bool:
            value = self.bool(forKey: key, default: defaultValue)

        case _ as String:
            value = self.string(forKey: key)

        case _ as Int:
            value = self.int(forKey: key)

        case _ as Double:
            value = self.double(forKey: key)

        case _ as Float:
            value = self.float(forKey: key)

        default: return defaultValue
        }

        if let value = value {
            // We unwrap first the optional value to avoid optional(optional(Type))
            // when an optional Type is given as defaultValue.
            // According to previous switch case, we could technically force
            // downcast to Type. But let be safe and swiftlint compliant.
            return value as? Type ?? defaultValue
        }

        return defaultValue

    }

    // MARK: -

    var delegates: [WeakRef<AnyObject>] = []

    func addObserver(_ observer: SwitchKitObserver) {
        delegates.append(WeakRef(observer))
    }

    // MARK: -

    func setValues(fromDict registrationDictionary: [String: Any]) {
        func flattern(_ dict: [String: Any], path: String? = nil) -> [String: String] {
            var values: [String: String] = [:]
            for key in dict.keys {
                let keyPath = (path?.appending(".") ?? "").appending(key)
                if let value = dict[key] as? String {
                    values[keyPath] = value
                }
                if let dict = dict[key] as? [String: Any] {
                    flattern(dict, path: keyPath).forEach { arg0 in
                        let (key, value) = arg0
                        values[key] = value
                    }
                }
            }
            return values
        }

        let values = flattern(registrationDictionary)
        storage.setValues(values)

        for key in values.keys {
            for delegate in delegates {
                guard let delegate = delegate.value as? SwitchKitObserver else {
                    continue
                }

                DispatchQueue.main.async {
                    delegate.didUpdateSwitch(name: key)
                }
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

/// Helper that provide a type-safe weak reference holder
/// https://marcosantadev.com/swift-arrays-holding-elements-weak-references/
class WeakRef<T> where T: AnyObject {
    private(set) weak var value: T?

    init(_ value: T?) {
        self.value = value
    }
}
