//
//  SortClass.swift
//  GoEuro
//
//  Created by lokesh vunnam on 10/9/16.
//  Copyright © 2016 lokesh. All rights reserved.
//

import UIKit

class SortClass: NSObject {
    
    // Sorting Flight Array List
    @objc func sortFlights (array:[Flight], sortKey:String) -> [Flight] {
        let sortValue: (Flight) -> String? = {
            $0.value(forKey: sortKey) as? String
        }
        return array.sorted {
            sortValue($0.0)! < sortValue($0.1)!
        }
    }
    
    // Sorting Trains Array List
    @objc func sortTrains (array:[Trains], sortKey:String) -> [Trains] {
        let sortValue: (Trains) -> String? = {
            $0.value(forKey: sortKey) as? String
        }
        return array.sorted {
            sortValue($0.0)! < sortValue($0.1)!
        }
    }

    // Sorting Bus Array List
    @objc func sortBusses (array:[Bus], sortKey:String) -> [Bus] {
        let sortValue: (Bus) -> String? = {
            $0.value(forKey: sortKey) as? String
        }
        return array.sorted {
            sortValue($0.0)! < sortValue($0.1)!
        }
    }
}
