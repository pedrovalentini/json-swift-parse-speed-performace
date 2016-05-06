//
//  ViewController.swift
//  JSONSpeed
//
//  Created by Pedro Valentini on 22/03/16.
//  Copyright © 2016 Mobicare. All rights reserved.
//

import UIKit
import Unbox
import ObjectMapper
import Argo
import Curry
import EVReflection

class ViewController: UIViewController {


    func readFile(name: String) -> NSData? {
        print("readFile")
        let bundle = NSBundle.mainBundle()
        if let path = bundle.pathForResource(name, ofType: "json") {
            return NSData(contentsOfFile: path)
        }
        return nil
    }

    func fileToDict(data: NSData?)  -> NSDictionary? {
        if data == nil {
            return nil
        }
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            return dict as? NSDictionary
        } catch {}
        return nil
    }

    func doTest(type: String, test: (data: NSData) -> ()) {
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("ERROR: COULD NOT READ FILE")
            return
        }

        print("\(type): start parse")
        let start = NSDate()

        test(data: data)

        print("\(type): finish parse in seconds \(NSDate().timeIntervalSinceDate(start))")
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        print("\n\n----- Dummy initial tests ---\n\n\n")
        tailorTest()
        unboxTest()
        objectMapperTest()
        argoTest()
        evReflectionTest()

        print("\n\n----- Start actual test ---\n\n\n")

        tailorTest()
        tailorTest()

        unboxTest()
        unboxTest()

        objectMapperTest()
        objectMapperTest()

        argoTest()
        argoTest()

        evReflectionTest()
        evReflectionTest()

    }

    func argoTest() {
        doTest("SpeedArgo") { data in
            let dict = self.fileToDict(data)
            let speed: SpeedArgo = decode(dict!)!
            print(speed.list.first!.name, speed.name)
        }
    }


    func objectMapperTest() {
        doTest("ObjectMapper") { data in
            let dict = self.fileToDict(data)
            let speed = SpeedObjectMapper(JSON: dict as! [String: AnyObject])!
            print(speed.list!.first!.name, speed.name)
        }
    }

    func evReflectionTest() {
        doTest("EVReflection") { data in
            let json = String(data: data, encoding: NSUTF8StringEncoding)
            let speed = SpeedReflection(json: json)
            print(speed.list!.first!.name, speed.name)
        }
    }

    func unboxTest() {
        doTest("Unbox") { data in
            if let dict = self.fileToDict(data) as? UnboxableDictionary {
                do {
                    let speed: SpeedUnbox = try Unbox(dict)
                    print(speed.list!.first!.name, speed.name)
                } catch _ {
                    print("ERROR: COULD NOT UNBOX")
                }
            } else {
                print("ERROR: DICTIONARY IS NOT UNBOXABLE")
            }
        }
    }

    func tailorTest() {
        doTest("EVReflection") { data in
            let dict = self.fileToDict(data) as! [String : AnyObject]
            let speed = SpeedTailor(dict)
            print("CRASH!?")
            //print(speed.list!.first!.name, speed.name)
        }
    }

}
