//
//  BSCancelTableView.m
//  BookSystem
//
//  Created by Dream on 11-7-13.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ZCCancelTableView.h"
#import "CVLocalizationSetting.h"

@implementation ZCCancelTableView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CVLocalizationSetting *langSetting = [CVLocalizationSetting sharedInstance];
        // Initialization code
        self.transform = CGAffineTransformIdentity;
        
        [self setTitle:[langSetting localizedString:@"Cancel Table"]];
        
        lblUser = [[UILabel alloc] initWithFrame:CGRectMake(20, 75, 70, 25)];
        lblUser.textAlignment = NSTextAlignmentCenter;
        lblUser.backgroundColor = [UIColor clearColor];
        lblUser.text = [langSetting localizedString:@"User:"];
        [self addSubview:lblUser];
        [lblUser release];
        
        tfUser.delegate = self;
        
        tfUser = [[UITextField alloc] initWithFrame:CGRectMake(95, 75, 140, 25)];
        tfUser.borderStyle = UITextBorderStyleRoundedRect;

        [self addSubview:tfUser];
        [tfUser release];

        
        btnConfirm = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnConfirm.frame = CGRectMake(75, 135, 40, 30);
        [btnConfirm setTitle:[langSetting localizedString:@"OK"] forState:UIControlStateNormal];
        [self addSubview:btnConfirm];
        btnConfirm.tag = 700;
        [btnConfirm addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        
        btnCancel = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        btnCancel.frame = CGRectMake(160, 135, 40, 30);
        [btnCancel setTitle:[langSetting localizedString:@"Cancel"] forState:UIControlStateNormal];
        [self addSubview:btnCancel];
        btnCancel.tag = 701;
        [btnCancel addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

- (void)dealloc
{
    self.delegate = nil;
    [super dealloc];
}


- (void)confirm{
    CVLocalizationSetting *langSetting = [CVLocalizationSetting sharedInstance];
    if ([tfUser.text length]<=0){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[langSetting localizedString:@"Error Table"] message:[langSetting localizedString:@"User could not be empty"] delegate:nil cancelButtonTitle:[langSetting localizedString:@"OK"] otherButtonTitles:nil];
        [alert show];
        [alert release];
    }
    else{
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        [dic setObject:tfUser.text forKey:@"user"];
        

        
        [delegate cancelTableWithOptions:dic];
    }
}

- (void)cancel{
    [delegate cancelTableWithOptions:nil];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{  //string就是此时输入的那个字符textField就是此时正在输入的那个输入框返回YES就是可以改变输入框的值NO相反
    CVLocalizationSetting *langSetting = [CVLocalizationSetting sharedInstance];
    if ([string isEqualToString:@"\n"])  //按会车可以改变
    {
        return YES;
    }
    
    NSString * toBeString = [textField.text stringByReplacingCharactersInRange:range withString:string]; //得到输入框的内容
    
    if (tfUser == textField)  //判断是否时我们想要限定的那个输入框
    {
        if ([toBeString length] > 10) { //如果输入框内容大于20则弹出警告
            textField.text = [toBeString substringToIndex:10];
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:[langSetting localizedString:@"More words"] delegate:nil cancelButtonTitle:[langSetting localizedString:@"OK"] otherButtonTitles:nil, nil] autorelease];
            [alert show];
            return NO;
        }
    }
    return YES;
}
@end

