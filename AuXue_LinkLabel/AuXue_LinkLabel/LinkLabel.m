//
//  LinkLabel.m
//  富文本Demo
//
//  Created by yangqijia on 2017/10/23.
//  Copyright © 2017年 yangqijia. All rights reserved.
//

#import "LinkLabel.h"

//判断字符串是否为空
#define isNil(string) ([string isEqual:[NSNull null]] || string == nil || [string isEqualToString:@""] ||[string isEqualToString:@"<null>"] || [string isEqualToString:@"(null)"])?(YES):(NO)

@interface LinkLabel()

@end

@implementation LinkLabel

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(topAction)]];
    }
    return self;
}

/**
 重写set方法

 @param title 显示内容
 */
-(void)setTitle:(NSString *)title
{
    if (!isNil(title)) {
        _title = title;
        if ([self checkTelNumber:title]) {
            self.attributedText = [self setAttributedString:title];
        }else if ([self validateEmail:title]){
            self.attributedText = [self setAttributedString:title];
        }else{
            self.text = title;
        }
    }
}

/**
 设置点击打开网页
 
 @param title 显示标题
 @param url 要打开的的链接
 */
-(void)setUrlWithTitle:(NSString *)title url:(NSString *)url
{
    if (!isNil(url)) {
        _url = url;
        if (!isNil(title)) {
            _title = title;
            self.attributedText = [self setAttributedString:_title];
        }
    }else{
        _url = @"";
        _title = title;
        self.text = title;
    }
}


/**
 设置链接显示样式

 @param title 显示内容
 @return 返回链接样式文本
 */
-(NSMutableAttributedString *)setAttributedString:(NSString *)title
{
    NSRange range = NSMakeRange(0, title.length);
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:title];
    //设置下划线
    [attribtStr addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:range];
    //字体颜色
    [attribtStr addAttribute:NSForegroundColorAttributeName value:[UIColor blueColor] range:range];
    return attribtStr;
}

//手机号码验证
-(BOOL)checkTelNumber:(NSString *)telNumber
{
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[06-8])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:telNumber];
}

//正则表达式判断邮箱
-(BOOL)validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//验证URL
-(BOOL)checkURL:(NSString*)url
{
    NSString*pattern =@"http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?";
    NSPredicate*pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
}

//点击事件
-(void)topAction
{
    if (!isNil(_url)) {
        if ([self checkURL:_url]) {
            NSURL *url = [NSURL URLWithString:_url];
            if (_linkBlack) {
                _linkBlack(LINK_TYPE,_title,url);
            }
        }
    }else if (!isNil(_title)){
        if ([self checkTelNumber:_title]) {
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_title]];
            if (_linkBlack) {
                _linkBlack(TEL_TYPE,_title,url);
            }
        }else if ([self validateEmail:_title]){
            NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",_title]];
            if (_linkBlack) {
                _linkBlack(EMAIL_TYPE,_title,url);
            }
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
