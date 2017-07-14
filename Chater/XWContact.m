//
//  XWContact.m
//  XWPhone
//
//  Created by viviwu on 16/9/12.
//  Copyright © 2016年 viviwu. All rights reserved.
//

#import "XWContact.h"
#include "pinyin.h"

@implementation XWContact

-(id)init{
    self=[super init];
    if (self) {
        _phoneArr = [NSMutableArray array]; 
    }
    return self;
}

- (instancetype)initWithPerson:(ABRecordRef)aperson {
    self=[super init];
    if (self) {
        _person = aperson;
        {
            _firstName = (NSString *)CFBridgingRelease(ABRecordCopyValue(_person, kABPersonFirstNameProperty));
            _lastName = (NSString *)CFBridgingRelease(ABRecordCopyValue(_person, kABPersonLastNameProperty));
            _compositeName=(NSString *)CFBridgingRelease(ABRecordCopyCompositeName(_person));
            if (!_lastName && _compositeName) {
                _lastName=[_compositeName substringToIndex:1];
            }
            if (!_firstName && _compositeName) {
                _firstName=[_compositeName substringWithRange:NSMakeRange(1, 1)];
            }
#if 0
            if (_lastName || _firstName) {
                NSMutableString *str=[NSMutableString string];
                if (_firstName)
                    [str appendString:_firstName];
                if (_firstName && _lastName)
                    [str appendString:@" "];
                if (_lastName)
                    [str appendString:_lastName];
                _fullName=str;
            }else{
                _fullName=_compositeName;
            }
#endif
            _latinName = [XWContact transform:_compositeName];
        }
        _filterNumber=[NSMutableString string];
        
        _recordID=[NSNumber numberWithInt:ABRecordGetRecordID(_person)];
        // Phone numbers
        {
            _phoneNumbers = [[NSMutableArray alloc] init];
            ABMultiValueRef mutiNumbers = ABRecordCopyValue(_person, kABPersonPhoneProperty);
            if (mutiNumbers) {
                for (int i = 0; i < ABMultiValueGetCount(mutiNumbers); ++i) {
                    ABMultiValueIdentifier identifier = ABMultiValueGetIdentifierAtIndex(mutiNumbers, i);
                    NSInteger index = ABMultiValueGetIndexForIdentifier(mutiNumbers, identifier);
                    if (index != -1) {
                        NSString *valueRef = CFBridgingRelease(ABMultiValueCopyValueAtIndex(mutiNumbers, index));
                        NSMutableString * multiNum=[NSMutableString string];
                        if (valueRef != NULL) {
                            NSString * number=[XWContact normalizePhoneNumber:valueRef];
                            [_phoneNumbers addObject:number];
                            [multiNum appendString:[NSString stringWithFormat:@"%@ ", number]];
                        }
                        _filterNumber=multiNum;
                    }
                }
                CFRelease(mutiNumbers);
            }
        }
        _sectionNum=0;
    }
    return self;
}

-(NSString *)lastNameFirstLetter{
    
    NSString * filterName=_lastName?_lastName:_compositeName;
    if (filterName.length<1) {
        return @"#";
    }
    NSString * resultStr=[[XWContact transform:filterName] substringToIndex:1];
//    NSString * reStr=[NSString stringWithFormat:@"%c", pinyinFirstLetter([_compositeName characterAtIndex:0])]; 
//    NSLog(@"%@==%@", resultStr, reStr);
    return resultStr;
}

-(NSString *)firstNameFirstLetter{
    
    NSString * filterName=_firstName?_firstName:_compositeName;
    if (filterName.length<1) {
        return @"#";
    }
    NSString * resultStr=[[XWContact transform:filterName] substringToIndex:1];
    //    NSString * reStr=[NSString stringWithFormat:@"%c", pinyinFirstLetter([_compositeName characterAtIndex:0])];
    //    NSLog(@"%@==%@", resultStr, reStr);
    return resultStr;
}

-(void)descriptionInfo
{
    NSLog(@"\n _recordID=%@\n _lastName=%@\n _compositeName=%@\n _filterNumber=%@", _recordID, _lastName, _compositeName, _filterNumber);
}

+ (NSString*)normalizePhoneNumber:(NSString*)address
{
    NSMutableString* lNormalizedAddress = [NSMutableString stringWithString:address];
    [lNormalizedAddress replaceOccurrencesOfString:@"+00"
                                        withString:@"00"
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@" "
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"("
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@")"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"-"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"#"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"*"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"+"
                                        withString:@"00"
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    return lNormalizedAddress;
}

+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    //    NSLog(@"%@", pinyin);
    return [pinyin lowercaseString];
}

- (void)dealloc {
    if (_person != nil && ABRecordGetRecordID(_person) == kABRecordInvalidID) {
        CFRelease(_person);
    }
    _person = nil;
}

@end
