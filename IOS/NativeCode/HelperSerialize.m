//
//  HelperSerialize.m
//  Unity-iPhone
//
//  Created by Jan Michael on 2/28/13.
//
//

#import "HelperSerialize.h"

@implementation HelperSerialize

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

@end
