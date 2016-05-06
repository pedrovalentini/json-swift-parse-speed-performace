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
            print(dict)
            return dict as? NSDictionary
        } catch {}
        return nil
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        evReflectionTest()
        evReflectionTest()

//        let speed = Mapper<SpeedObjectMapper>().map(dict)!
//        let speed = SpeedObjectMapper(JSON: dict as! [String: AnyObject])!

//        let speed: SpeedUnbox? = Unbox(dict as! [String: AnyObject])!

//        let dict2 = dict as? [String: AnyObject]
//        let speed = SpeedTailor(dict)

//        let speed: SpeedArgo? = decode(dict!)


//        print(speed!.list.first!.name, speed!.name)
//        print(speed) // CAN ADD TIME TO PARSE TIME...



    }

    func evReflectionTest() {
        guard let data: NSData = readFile("speed") else {
            print("COULD NOT READ FILE")
            return
        }
        let json = String(data: data, encoding: NSUTF8StringEncoding)

        print("EVReflection: START PARSE")
        let start = NSDate()

        let speed = SpeedReflection(json: json)

        print(speed.list!.first!.name, speed.name)
        print("EVReflection: FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
