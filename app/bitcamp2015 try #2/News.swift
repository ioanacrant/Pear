//
//  News.swift
//  bitcamp2015 try #2
//
//  Created by Suraj Rampure on 2015-04-11.
//  Copyright (c) 2015 Suraj Rampure. All rights reserved.
//

import Foundation

struct News{
    let title: String
    let summary: String
    let fulltext: String
    let imageurl: String
    
    init(title: String, summary: String, fulltext: String, imageurl: String){
        self.title = title
        self.summary = summary
        self.fulltext = fulltext
        self.imageurl = imageurl
    }
}