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

+ (NSString *)imageType:(UploadImageType)imageType {
    NSArray *types = @[@"merchants_introduce_img", @"service_introduce_img", @"operator_id_img_a", @"operator_id_img_b", @"shop_license_img", @"shop_imgs"];
    return types[imageType];
}

+ (NSString *)appVersion {
    NSString *key = (NSString *)kCFBundleVersionKey;
    // 从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    NSLog(@"version---%@---",version);
    return @"1.0.0";
}

///////////////////////////////////////////////////////////////////////

+ (NSArray *)appsendverfcode:(NSString *)username type:(NSString *)type uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@appsendverfcode.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"type":type, @"uuid":uuid, @"usertype":@"1", @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mapplogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid {
    NSString *url = [NSString stringWithFormat:@"%@mapplogin.action",[Interface url]];
    NSDictionary *param = @{@"username":username, @"password":password, @"type":type, @"verf_code":verf_code, @"uuid":uuid, @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile verf_code:(NSString *)verf_code {
    NSString *url = [NSString stringWithFormat:@"%@mappregister.action",[Interface url]];
    UIDevice *device = [UIDevice currentDevice];
    NSString *terminal_os = [NSString stringWithFormat:@"%@%@",[device systemName], [device systemVersion]];
    NSString *terminal_type = [device model];
    NSDictionary *param = @{@"username":username, @"password":password, @"mobile":mobile, @"terminal_os":terminal_os, @"terminal_type":terminal_type, @"verf_code":verf_code, @"user_type":@"1"};
    return @[url,param];
}
///////////////////////////////////////////////////////////////////////

+ (NSArray *)mappupload:(NSInteger)file_count imageType:(UploadImageType)imageType {
    NSString *url = [NSString stringWithFormat:@"%@upload",[Interface url]];
    NSString *uploadType = [Interface imageType:imageType];
    NSDictionary *param = @{@"username":[Interface username], @"type":uploadType, @"file_count":[NSString stringWithFormat:@"%ld",file_count], @"token":[Interface token], @"version":[Interface appVersion]};
    
    return @[url, param];
}
///////////////////////////////////////////////////////////////////////


+ (NSArray *)mapppubservicesName:(NSString *)name detail:(NSString *)detail price:(NSString *)price type:(NSString *)type scope:(NSString *)scope imgpath:(NSString *)imgpath {
    NSString *url = [NSString stringWithFormat:@"%@mapppubservices.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"name":name, @"detail":detail, @"price":price, @"type":type, @"scope":scope, @"imgpath":imgpath, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappgetstatisticsData_time:(NSString *)data_time {
    NSString *url = [NSString stringWithFormat:@"%@mappgetstatistics.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"data_time":data_time, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappgetadvise {
    NSString *url = [NSString stringWithFormat:@"%@mappgetadvise.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappgetcomplaint {
    NSString *url = [NSString stringWithFormat:@"%@mappgetcomplaint.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappgetpubedservice {
    NSString *url = [NSString stringWithFormat:@"%@mappgetpubedservice.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappuploadintroduce:(NSString *)introduce {
    NSString *url = [NSString stringWithFormat:@"%@mappuploadintroduce.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"introduce":introduce, @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

+ (NSArray *)mappbinding {
    NSString *url = [NSString stringWithFormat:@"%@mappbinding.action",[Interface url]];
    NSDictionary *param = @{@"username":[Interface username], @"token":[Interface token], @"version":[Interface appVersion]};
    return @[url,param];
}

@end
