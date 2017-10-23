//
//  LinkLabel.h
//  富文本Demo
//
//  Created by yangqijia on 2017/10/23.
//  Copyright © 2017年 yangqijia. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    TEL_TYPE,
    EMAIL_TYPE,
    LINK_TYPE
}TextType;

typedef void(^TapLinkBlack)(TextType type, NSString *text, NSURL *url);

@interface LinkLabel : UILabel

/**
 设置显示内容
 */
@property(nonatomic ,strong)NSString *title;

/**
 网址链接
 */
@property(nonatomic ,strong)NSString *url;

@property(nonatomic ,copy)TapLinkBlack linkBlack;

/**
 设置点击打开网页

 @param title 显示标题
 @param url 要打开的的链接
 */
-(void)setUrlWithTitle:(NSString *)title url:(NSString *)url;

@end
