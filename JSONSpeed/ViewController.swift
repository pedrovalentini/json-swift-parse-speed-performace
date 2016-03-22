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


class ViewController: UIViewController {

    static func readFile(name: String) -> NSDictionary? {
        print("readFile")
        let bundle = NSBundle.mainBundle()
        let path = bundle.pathForResource(name, ofType: "json")
        let data = NSData(contentsOfFile: path!)
        do {
            let dict = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            print(dict)
            return dict as? NSDictionary
        }catch {}
        return nil
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("START")
        let start = NSDate()
        let dict = ViewController.readFile("speed")
        
        
        let speed = SpeedReflection(dictionary: dict!)
        
//        let speed = Mapper<SpeedObjectMapper>().map(dict)!
//        let speed = SpeedObjectMapper(JSON: dict as! [String: AnyObject])!
        
//        let speed: SpeedUnbox? = Unbox(dict as! [String: AnyObject])!
        
//        let dict2 = dict as? [String: AnyObject]
//        let speed = SpeedTailor(dict)
        
//        let speed: SpeedArgo? = decode(dict!)
        
        
//        print(speed!.list.first!.name, speed!.name)
        print(speed.list!.first!.name, speed.name)
//        print(speed) // CAN ADD TIME TO PARSE TIME...
        
        print("FINISH PARSE IN SECONDS \(NSDate().timeIntervalSinceDate(start))")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

