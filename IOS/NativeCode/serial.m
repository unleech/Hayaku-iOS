//#import <Foundation/Foundation.h>
//
//// clang -g -Wall -fobjc-arc -framework Foundation -o serial serial.m
//
//
//static id makePlistObjects (void) {
//    NSMutableDictionary *top = [NSMutableDictionary dictionary];
//
//    [top setObject: @"Hi I'm a string"  forKey: @"string"];
//    [top setObject: [NSNumber numberWithInt: 23]  forKey: @"number"];
//    [top setObject: [NSNumber numberWithBool: YES]  forKey: @"boolean"];
//    [top setObject: [NSDate date]  forKey: @"date"];
//    [top setObject: [NSData dataWithBytes: "badger"  length: 7] forKey: @"data"];
//
//    NSArray *array =
//        [NSArray arrayWithObjects: @"I", @"seem", @"to", @"be", @"a", @"verb", nil];
//    [top setObject: array  forKey: @"array"];
//
//    NSDictionary *dict =
//        [NSDictionary dictionaryWithObjectsAndKeys:
//                      @"Ack", @"Oop",
//                      @"Bill the Cat", @"It's", nil];
//    [top setObject: dict  forKey: @"dictionary"];
//
//    return top;
//
//} // makePlistObjects
//
//
//// --------------------------------------------------
//// Writing and reading property list objects
//
//static void saveAsOpenStep (id plist) {
//    if (![NSPropertyListSerialization
//             propertyList: plist
//             isValidForFormat: kCFPropertyListOpenStepFormat]) {
//        NSLog (@"can't save as open step");
//        return;
//    }
//
//    // Turns out you can't save as open step any more - just read them.  Bummer.
//    
//} // saveAsOpenStep
//
//
//static void saveAsXML (id plist) {
//    if (![NSPropertyListSerialization 
//             propertyList: plist
//             isValidForFormat: kCFPropertyListXMLFormat_v1_0]) {
//        NSLog (@"can't save as XML");
//        return;
//    }
//
//    NSError *error;
//    NSData *data = 
//        [NSPropertyListSerialization dataWithPropertyList: plist
//                                     format: kCFPropertyListXMLFormat_v1_0
//                                     options: 0
//                                     error: &error];
//    if (data == nil) {
//        NSLog (@"error serializing to xml: %@", error);
//        return;
//    }
//
//    BOOL writeStatus = [data writeToFile: @"plist.xml"
//                             options: NSDataWritingAtomic
//                             error: &error];
//    if (!writeStatus) {
//        NSLog (@"error writing to file: %@", error);
//        return;
//    }
//
//} // saveAsXML
//
//
//static void saveAsBinary (id plist, NSString *filename) {
//    if (![NSPropertyListSerialization
//          propertyList: plist
//          isValidForFormat: kCFPropertyListBinaryFormat_v1_0]) {
//        NSLog (@"can't save as binary");
//        return;
//    }
//    
//    NSError *error;
//    NSData *data =
//    [NSPropertyListSerialization dataWithPropertyList: plist
//                                               format: kCFPropertyListBinaryFormat_v1_0
//                                              options: 0
//                                                error: &error];
//    if (data == nil) {
//        NSLog (@"error serializing to xml: %@", error);
//        return;
//    }
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectoryPath
//                          stringByAppendingPathComponent:filename];
//    
//    BOOL writeStatus = [data writeToFile: filePath
//                                 options: NSDataWritingAtomic
//                                   error: &error];
//    if (!writeStatus) {
//        NSLog (@"error writing to file: %@", error);
//        return;
//    }
//    
//} // saveAsBinary
//
//static id readFromFile (NSString *filename) {
//    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains( NSCachesDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
//    NSString *filePath = [documentsDirectoryPath
//                          stringByAppendingPathComponent:filename];
//    
//    NSError *error;
//    NSData *data = [NSData dataWithContentsOfFile: filePath
//                                          options: 0
//                                            error: &error];
//    if (data == nil) {
//        NSLog (@"error reading %@: %@", filePath, error);
//        return nil;
//    }
//    
//    NSPropertyListFormat format;
//    id plist = [NSPropertyListSerialization propertyListWithData: data
//                                                         options: NSPropertyListImmutable
//                                                          format: &format
//                                                           error: &error];
//    
//    
//    
//    if (plist == nil) {
//        NSLog (@"could not deserialize %@: %@", filePath, error);
//    } else {
//        NSString *formatDescription;
//        switch (format) {
//            case NSPropertyListOpenStepFormat:
//                formatDescription = @"openstep";
//                break;
//            case NSPropertyListXMLFormat_v1_0:
//                formatDescription = @"xml";
//                break;
//            case NSPropertyListBinaryFormat_v1_0:
//                formatDescription = @"binary";
//                break;
//            default:
//                formatDescription = @"unknown";
//                break;
//        }
//        NSLog (@"%@ was in %@ format", filePath, formatDescription);
//    }
//    
//    return plist;
//    
//} // readFromFile
//
//
//// --------------------------------------------------
//// Writing and reading JSON
//
//static void saveAsJSON (id plist) {
//    if (![NSJSONSerialization isValidJSONObject: plist]) {
//        NSLog (@"can't save as JSON");
//        return;
//    }
//
//    NSError *error;
//    NSData *data = 
//        [NSJSONSerialization dataWithJSONObject: plist
//                             options: 0 // NSJSONWritingPrettyPrinted
//                             error: &error];
//    if (data == nil) {
//        NSLog (@"error serializing to json: %@", error);
//        return;
//    }
//
//    BOOL writeStatus = [data writeToFile: @"plist.json"
//                             options: NSDataWritingAtomic
//                             error: &error];
//    if (!writeStatus) {
//        NSLog (@"error writing to file: %@", error);
//        return;
//    }
//
//} // saveAsJSON
//
//
//
//static id readFromJSONFile (NSString *path) {
//    NSError *error;
//    NSData *data = [NSData dataWithContentsOfFile: path
//                           options: 0
//                           error: &error];
//    if (data == nil) {
//        NSLog (@"error reading %@: %@", path, error);
//        return nil;
//    }
//
//    id plist = [NSJSONSerialization JSONObjectWithData: data
//                                    options: 0
//                                    error: &error];
//    if (plist == nil) {
//        NSLog (@"could not deserialize %@: %@", path, error);
//    }
//    
//    return plist;
//
//} // readFromJSONFile
