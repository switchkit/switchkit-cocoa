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

import XCTest
@testable import SwitchKit

class SwitchKitTests: XCTestCase {

    var instance = SwitchKit(storage: SwitchKitStorageMemory())

    override func setUp() {
        /// Clean up SwitchKit instance before each test
        instance = SwitchKit(storage: SwitchKitStorageMemory())
    }

    func testSetValuesFlattern() {
        instance.setValues(fromDict: [
            "key1": "value1",
            "key2": [
                "subkey1": "value2",
                "subkey2": "value3"
            ]])

        XCTAssertEqual(instance.storage.value(forKey: "key1"), "value1")
        XCTAssertEqual(instance.storage.value(forKey: "key2.subkey1"), "value2")
        XCTAssertEqual(instance.storage.value(forKey: "key2.subkey2"), "value3")
        XCTAssertEqual(instance.storage.value(forKey: "key2"), nil)
        XCTAssertEqual(instance.storage.value(forKey: "key3"), nil)
    }

    func testValueBool() {
        instance.setValues(fromDict: [
            "string": "string",
            "empty": "",
            "false": "false",
            "zero": "0"
            ])

        XCTAssertEqual(instance.value("string", default: false), true)
        XCTAssertEqual(instance.value("string", default: true), true)
        XCTAssertEqual(instance.value("empty", default: false), false)
        XCTAssertEqual(instance.value("empty", default: true), false)
        XCTAssertEqual(instance.value("unknown", default: false), false)
        XCTAssertEqual(instance.value("unknown", default: true), true)

        // Any non-empty string is evaluated as true
        XCTAssertEqual(instance.value("false", default: false), true)
        XCTAssertEqual(instance.value("false", default: true), true)
        XCTAssertEqual(instance.value("zero", default: false), true)
        XCTAssertEqual(instance.value("zero", default: true), true)
    }

    func testValueString() {
        instance.setValues(fromDict: [
            "string": "string",
            "empty": ""
            ])

        XCTAssertEqual(instance.value("string", default: "fallback"), "string")
        XCTAssertEqual(instance.value("empty", default: "fallback"), "")
        XCTAssertEqual(instance.value("unknown", default: "fallback"), "fallback")
    }

    func testValueInt() {
        instance.setValues(fromDict: [
            "val_0": "0",
            "val_10": "10",
            "val_10.0": "10.0"
            ])

        XCTAssertEqual(instance.value("val_0", default: 5), 0)
        XCTAssertEqual(instance.value("val_10", default: 5), 10)
        XCTAssertEqual(instance.value("val_10.0", default: 5), 10)
        XCTAssertEqual(instance.value("val_unknown", default: 5), 5)
    }

    func testValueIntInvalid() {
        instance.setValues(fromDict: [
            "val_alpha": "alpha",
            "val_alpha10": "alpha10",
            "val_10alpha": "10alpha",
            "val_10.0.1": "10.0.1",
            "val_empty": ""
            ])

        XCTAssertEqual(instance.value("val_alpha", default: 5), 5)
        XCTAssertEqual(instance.value("val_alpha10", default: 5), 5)
        XCTAssertEqual(instance.value("val_10alpha", default: 5), 5)
        XCTAssertEqual(instance.value("val_10.0.1", default: 5), 5)
        XCTAssertEqual(instance.value("val_empty", default: 5), 5)
    }

    func testValueOptionalInt() {
        instance.setValue("0", forKey: "val_0")

        XCTAssertEqual(instance.value("val_0", default: Optional(5)), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(5)), 5)
        XCTAssertEqual(instance.value("val_0", default: Optional(Optional(5))), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(Optional(5))), 5)
    }

    func testValueDouble() {
        instance.setValues(fromDict: [
            "val_0": "0",
            "val_10": "10",
            "val_10.0": "10.0"
            ])

        XCTAssertEqual(instance.value("val_0", default: 5.0), 0)
        XCTAssertEqual(instance.value("val_10", default: 5.0), 10)
        XCTAssertEqual(instance.value("val_10.0", default: 5.0), 10)
        XCTAssertEqual(instance.value("val_unknown", default: 5.0), 5)
    }

    func testValueDoubleInvalid() {
        instance.setValues(fromDict: [
            "val_alpha": "alpha",
            "val_alpha10": "alpha10",
            "val_10alpha": "10alpha",
            "val_10.0.1": "10.0.1",
            "val_empty": ""
            ])

        XCTAssertEqual(instance.value("val_alpha", default: 5.0), 5)
        XCTAssertEqual(instance.value("val_alpha10", default: 5.0), 5)
        XCTAssertEqual(instance.value("val_10alpha", default: 5.0), 5)
        XCTAssertEqual(instance.value("val_10.0.1", default: 5.0), 5)
        XCTAssertEqual(instance.value("val_empty", default: 5.0), 5)
    }

    func testValueOptionalDouble() {
        instance.setValue("0", forKey: "val_0")

        XCTAssertEqual(instance.value("val_0", default: Optional(5.0)), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(5.0)), 5)
        XCTAssertEqual(instance.value("val_0", default: Optional(Optional(5.0))), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(Optional(5.0))), 5)
    }

    func testValueFloat() {
        instance.setValues(fromDict: [
            "val_0": "0",
            "val_10": "10",
            "val_10.0": "10.0"
            ])

        XCTAssertEqual(instance.value("val_0", default: Float(5)), 0)
        XCTAssertEqual(instance.value("val_10", default: Float(5)), 10)
        XCTAssertEqual(instance.value("val_10.0", default: Float(5)), 10)
        XCTAssertEqual(instance.value("val_unknown", default: Float(5)), 5)
    }

    func testValueFloatInvalid() {
        instance.setValues(fromDict: [
            "val_alpha": "alpha",
            "val_alpha10": "alpha10",
            "val_10alpha": "10alpha",
            "val_10.0.1": "10.0.1",
            "val_empty": ""
            ])

        XCTAssertEqual(instance.value("val_alpha", default: Float(5)), 5)
        XCTAssertEqual(instance.value("val_alpha10", default: Float(5)), 5)
        XCTAssertEqual(instance.value("val_10alpha", default: Float(5)), 5)
        XCTAssertEqual(instance.value("val_10.0.1", default: Float(5)), 5)
        XCTAssertEqual(instance.value("val_empty", default: Float(5)), 5)
    }

    func testValueOptionalFloat() {
        instance.setValue("0", forKey: "val_0")

        XCTAssertEqual(instance.value("val_0", default: Optional(Float(5))), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(Float(5))), 5)
        XCTAssertEqual(instance.value("val_0", default: Optional(Optional(Float(5)))), 0)
        XCTAssertEqual(instance.value("unknown", default: Optional(Optional(Float(5)))), 5)
    }

    func testValueUnsupportedType() {
        instance.setValue("value", forKey: "key")

        // swiftlint:disable:next nesting
        struct Custom: Equatable {}
        let defaultValue = Custom()

        XCTAssertEqual(instance.value("key", default: defaultValue), defaultValue)
    }

}
