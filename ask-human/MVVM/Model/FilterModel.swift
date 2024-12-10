//
//  FilterModel.swift
//  ask-human
//
//  Created by meet sharma on 22/12/23.
//

import Foundation

struct FilterModel{
    var selectFilter: [String:Any]?
    init(selectFilter: [String : Any]? = nil) {
        self.selectFilter = selectFilter
    }
    
}
