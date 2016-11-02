//
//  XMLParser.swift
//  SteamPoweredApp
//
//  Created by user117643 on 11/1/16.
//  Copyright © 2016 Krudeboy51. All rights reserved.
//

import UIKit

@objc protocol XMLParserDelegate{
    func parsingWasFinished()
}

class XMLParser: NSObject, NSXMLParserDelegate {
    
    var arrParsedData = [Dictionary<String, String>]()
    
    var currentDataDictionary = Dictionary<String, String>()
    
    var currentElement = ""
    
    var foundCharacters = ""
    
    var delegate: XMLParserDelegate?

    func startParsingFromURL(rssURL: NSURL){
        let parser = NSXMLParser(contentsOfURL: rssURL)
        parser!.delegate = self
        parser!.parse()
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        currentElement = elementName
    }
    
    func parser(parser: NSXMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if !foundCharacters.isEmpty {
            
            if elementName == "link"{
            foundCharacters = (foundCharacters as NSString).substringFromIndex(4)
                // ^ instead of 3 like in appcoda, this requires 4 to remove etras in the link e.g: \n\t\thttp://www.steampowered.com/
            }
            
            currentDataDictionary[currentElement] = foundCharacters
            
            foundCharacters = ""
        
            if currentElement == "pubDate" {
            arrParsedData.append(currentDataDictionary)
            }
        }
    }
    
    func parser(parser: NSXMLParser, foundCharacters string: String) {
        if currentElement == "title" || currentElement == "link" || currentElement == "pubDate"{
            foundCharacters += string
        }
    }
    
    func parser(parser: NSXMLParser, parseErrorOccurred parseError: NSError) {
                print(parseError.description)
    }
    
    
    func parser(parser: NSXMLParser, validationErrorOccurred validationError: NSError) {
                print(validationError.description)
    }
    
    
    func parserDidEndDocument(parser: NSXMLParser) {
                delegate!.parsingWasFinished()
    }
    
    
}
