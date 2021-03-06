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

typedef NS_ENUM(NSUInteger, UploadImageType) {
    Merchants_introduce_img,    //上传企业介绍图片
    Service_introduce_img,      //上传服务介绍图片
    Operator_id_img_a,          //上传经营者身份证照正面图片
    Operator_id_img_b,          //上传经营者身份证照反面图片
    Shop_license_img,           //上传营业执照图片
    Shop_imgs,                  //上传店面图片
};

@interface Interface : NSObject

+ (NSString *)username;

+ (NSString *)token;

+ (NSString *)uuid;

+ (NSString *)url;

+ (NSString *)imageType:(UploadImageType)imageType;

//send verf_code 发送验证码
+ (NSArray *)appsendverfcode:(NSString *)username type:(NSString *)type uuid:(NSString *)uuid;

//check verf_code
+ (NSArray *)appcheckverfcode:(NSString *)username mobile:(NSString *)mobile verf_code:(NSString *)verf_code type:(NSString *)type uuid:(NSString *)uuid;

//login 登录
+ (NSArray *)mapplogin:(NSString *)username password:(NSString *)password type:(NSString *)type verf_code:(NSString *)verf_code uuid:(NSString *)uuid;

//register 注册
+ (NSArray *)mappregister:(NSString *)username password:(NSString *)password mobile:(NSString *)mobile verf_code:(NSString *)verf_code;


//mappfileupload 上传图片
+ (NSArray *)mappupload:(NSInteger)file_count imageType:(UploadImageType)imageType;

//mapppubservices 发布服务
+ (NSArray *)mapppubservicesName:(NSString *)name detail:(NSString *)detail price:(NSString *)price type:(NSString *)type scope:(NSString *)scope imgpath:(NSString *)imgpath;

//mappgetstatistics 获取统计数据
+ (NSArray *)mappgetstatisticsData_time:(NSString *)data_time;

//mappgetadvise 获取用户评论
+ (NSArray *)mappgetadvise;

//mappgetcomplaint 获取投诉处理
+ (NSArray *)mappgetcomplaint;

//mappgetpubedservice 获取已发布服务
+ (NSArray *)mappgetpubedservice;

//获取预约信息
+ (NSArray *)mappgetsubscribe;

//获取店铺信息
+ (NSArray *)mappgetshopinfo;

//mappuploadintroduce 上传企业简介
+ (NSArray *)mappuploadintroduce:(NSString *)introduce;

//mappbinding 商家APP账号绑定
+ (NSArray *)mappbinding;

//mappsubmitparkinfo 提交入驻申请信息
+ (NSArray *)mappsubmitparkinfo:(NSString *)operator_name operator_id:(NSString *)operator_id operator_id_img_a:(NSString *)operator_id_img_a operator_id_img_b:(NSString *)operator_id_img_b shop_introduce:(NSString *)shop_introduce shop_imgs:(NSString *)shop_imgs shop_name:(NSString *)shop_name shop_area:(NSString *)shop_area shop_address:(NSString *)shop_address shop_mobile:(NSString *)shop_mobile shop_license_img:(NSString *)shop_license_img;

@end
