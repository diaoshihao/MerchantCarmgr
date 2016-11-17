//
//  Interface.m
//  MerchantCarmgr
//
//  Created by admin on 2016/11/10.
//  Copyright © 2016年 yiwuchebao. All rights reserved.
//

#import "Interface.h"

@implementation Interface

+ (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
}

+ (NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
}

+ (NSString *)uuid {
    NSString *uuid = [[NSUUID UUID] UUIDString];
    return uuid;
}

+ (NSString *)url {
    return @"http://112.74.13.51:8080/carmgr/";
}

+ (NSString *)appVersion {
    return @"1.0";
}

///////////////////////////////////////////////////////////////////////

+ (NSArray *)appsendverfcode:(NSString *)username type:(NSString *)type uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appsendverfcode",[Interface url]];
    NSDictionary *param = @{@"username":username, @"type":type, @"uuid":uuid, @"usertype":@"1", @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mapplogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@mapplogin",[Interface url]];
    NSDictionary *param = @{@"username":username, @"password":password, @"type":type, @"verf_code":verf_code, @"uuid":uuid, @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile verf_code:(NSString *)verf_code {
    NSString *url = [NSString stringWithFormat:@"%@mappregister",[Interface url]];
    NSString *terminal_os = @"iOS";
    NSString *terminal_type = @"iPhone";
    NSDictionary *param = @{@"username":username, @"password":password, @"mobile":mobile, @"terminal_os":terminal_os, @"terminal_type":terminal_type, @"verf_code":verf_code, @"user_type":@"1"};
    return @[url,param];
}
///////////////////////////////////////////////////////////////////////


+ (NSArray *)mapppubservicesName:(NSString *)name detail:(NSString *)detail price:(NSString *)price type:(NSString *)type scope:(NSString *)scope imgpath:(NSString *)imgpath {
    NSString *url = [NSString stringWithFormat:@"%@mapppubservices",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"name":name, @"detail":detail, @"price":price, @"type":type, @"scope":scope, @"imgpath":imgpath, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappfileupload:(NSArray *)images fileType:(NSString *)type {
    NSString *url = [NSString stringWithFormat:@"%@mappfileupload",[Interface url]];
    NSData *data = UIImageJPEGRepresentation(images.firstObject, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    NSDictionary *param = @{@"filedata":encodedImageStr};
    return @[url, param];
}

@end
