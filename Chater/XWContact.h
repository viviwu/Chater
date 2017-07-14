//
//  XWContact.h
//  XWPhone
//
//  Created by viviwu on 16/9/12.
//  Copyright © 2016年 viviwu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface XWContact : NSObject

@property(nonatomic, readonly) ABRecordRef person;
@property (nonatomic, copy) NSNumber * recordID;
@property(nonatomic, copy) NSString *firstName;
@property(nonatomic, copy) NSString *lastName;
//@property(nonatomic, copy) NSString *fullName;
@property(nonatomic, copy) NSString *compositeName;//综合名称 包含组织信息
@property(nonatomic, copy) NSString *latinName;
@property(nonatomic, copy) NSString *filterNumber;

@property(nonatomic, strong) NSMutableArray *phoneNumbers;
@property(nonatomic, assign) NSInteger sectionNum;

- (instancetype)initWithPerson:(ABRecordRef)person;

-(NSString *)lastNameFirstLetter;
-(NSString *)firstNameFirstLetter;
-(void)descriptionInfo;


@property (nonatomic, strong) NSNumber * rid;
@property (nonatomic, strong) NSData * avatar;
@property (nonatomic, copy)  NSString * name;

@property (nonatomic,strong) NSMutableArray * phoneArr;
//@property (nonatomic,strong) NSMutableDictionary * sipphoneDic;

@property (nonatomic, copy)  NSString * phone;
@property (nonatomic, copy)   NSString * userId;
@property (nonatomic, assign) BOOL isUser;//是否为游游通用户

@property (nonatomic, assign) NSInteger originIndex;

+ (NSString*)normalizePhoneNumber:(NSString*)address;

@end
