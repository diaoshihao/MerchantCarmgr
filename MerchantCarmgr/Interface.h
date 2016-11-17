//
//  Interface.h
//  MerchantCarmgr
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyNetworker.h"

typedef NS_ENUM(NSUInteger, Request) {
    InterfaceUrl,
    Parameters,
};

@interface Interface : NSObject

+ (NSString *)username;

+ (NSString *)token;

+ (NSString *)uuid;

+ (NSString *)url;

//send verf_code
+ (NSArray *)appsendverfcode:(NSString *)username type:(NSString *)type uuid:(NSString *)uuid;

//login
+ (NSArray *)mapplogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid;

//register
+ (NSArray *)mappregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile verf_code:(NSString *)verf_code;


//mapppubservices
//+ (NSArray *)mapppubservices:(NSString *)username name:(NSString *)name detail:(NSString *)detail price:(NSString *)price type:(NSString *)type scope:(NSString *)scope imgpath:(NSString *)imgpath token:(NSString *)token;
+ (NSArray *)mapppubservicesName:(NSString *)name detail:(NSString *)detail price:(NSString *)price type:(NSString *)type scope:(NSString *)scope imgpath:(NSString *)imgpath;

//mappfileupload
+ (NSArray *)mappfileupload:(NSArray *)images fileType:(NSString *)type;

@end
