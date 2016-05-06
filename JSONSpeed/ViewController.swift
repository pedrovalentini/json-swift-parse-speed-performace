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
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }

        print("SpeedArgo: START PARSE")
        let start = NSDate()

        // Test this
        let dict = fileToDict(data)
        let speed: SpeedArgo = decode(dict!)!

        // Show results
        print(speed.list.first!.name, speed.name)
        print("SpeedArgo: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
    }

    func tailorTest() {
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }

        print("Tailor: START PARSE")
        let start = NSDate()

        // Test this
        let dict = fileToDict(data) as! [String : AnyObject]
        let speed = SpeedTailor(dict)

        // Show results
        print("CRASH!?")
        //print(speed.list!.first!.name, speed.name)
        //print("Tailor: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
    }

    func unboxTest() {
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }

        print("UNBOX: START PARSE")
        let start = NSDate()

        // Test this
        if let dict = fileToDict(data) as? UnboxableDictionary {
            do {
                let speed: SpeedUnbox = try Unbox(dict)

                // Show results
                print(speed.list!.first!.name, speed.name)
                print("UNBOX: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
            } catch _ {
                print("COULD NOT UNBOX")
            }
        } else {
            print("DICTIONARY IS NOT UNBOXABLE")
        }
    }

    func objectMapperTest() {
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }

        print("OBJECTMAPPER2: START PARSE")
        let start = NSDate()

        // Test this
        let dict = fileToDict(data)
        let speed = SpeedObjectMapper(JSON: dict as! [String: AnyObject])!

        // Show results
        print(speed.list!.first!.name, speed.name)
        print("OBJECTMAPPER2: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
    }


    func evReflectionTest() {
        // Prepare for test
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }
        let json = String(data: data, encoding: NSUTF8StringEncoding)

        print("EVREFLECTION: START PARSE")
        let start = NSDate()

        // Test this
        let speed = SpeedReflection(json: json)

        // Show results
        print(speed.list!.first!.name, speed.name)
        print("EVREFLECTION: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
