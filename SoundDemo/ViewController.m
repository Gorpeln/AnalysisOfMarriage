//
//  ViewController.m
//  SoundDemo
//
//  Created by chen on 2017/1/20.
//  Copyright © 2017年 GorPeln. All rights reserved.
//

#define IsValidUserName(userName)\
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^[\u4e00-\u9fa5]{2,5}$"] evaluateWithObject:userName]

#import "ViewController.h"
#import "Masonry.h"

#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController ()<UITextFieldDelegate>

@property(nonatomic,strong) UILabel                 *titleLabel;
@property(nonatomic,strong) UILabel                 *manTipLabel;
@property(nonatomic,strong) UITextField             *manTextField;
@property(nonatomic,strong) UILabel                 *womanTipLabel;
@property(nonatomic,strong) UITextField             *womanTextField;
@property(nonatomic,strong) UIButton                *analysisBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text = @"姻缘分析";
    _titleLabel.textColor = [UIColor redColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = [UIFont systemFontOfSize:20.0];
    [self.view addSubview:_titleLabel];
    
    
    _manTipLabel = [[UILabel alloc]init];
    _manTipLabel.text = @"男生";
    _manTipLabel.layer.borderWidth = 0.5;
    _manTipLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _manTipLabel.clipsToBounds =YES;
    _manTipLabel.layer.cornerRadius = 6.0;
    _manTipLabel.textAlignment = NSTextAlignmentCenter;
    _manTipLabel.font = [UIFont systemFontOfSize:15.0];
    [self.view addSubview:_manTipLabel];
    
    
    _manTextField = [[UITextField alloc]init];
    _manTextField.placeholder = @"输入中文名字 至少两个字";
    [_manTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_manTextField setValue:[UIFont systemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _manTextField.delegate=self;
    _manTextField.borderStyle = UITextBorderStyleNone;
    _manTextField.font = [UIFont fontWithName:@"helvetica" size:14.0];
    _manTextField.clearButtonMode = UITextFieldViewModeWhileEditing;//一键删除
    _manTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直对其的方式
    _manTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _manTextField.keyboardType = UIKeyboardTypeDefault;
    _manTextField.layer.borderWidth = 0.5;
    _manTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _manTextField.clipsToBounds =YES;
    _manTextField.layer.cornerRadius = 6.0;
    _manTextField.returnKeyType = UIReturnKeyNext;
    [_manTextField becomeFirstResponder];//键盘第一响应
    [_manTextField setSecureTextEntry:NO]; //隐藏字符
    [self.view addSubview:_manTextField];
  
    
    _womanTipLabel = [[UILabel alloc]init];
    _womanTipLabel.text = @"女生";
    _womanTipLabel.layer.borderWidth = 0.5;
    _womanTipLabel.layer.borderColor = [UIColor blackColor].CGColor;
    _womanTipLabel.clipsToBounds =YES;
    _womanTipLabel.layer.cornerRadius = 6.0;
    _womanTipLabel.font = [UIFont systemFontOfSize:15.0];
    _womanTipLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_womanTipLabel];
    
    
    _womanTextField = [[UITextField alloc]init];
    _womanTextField.placeholder = @"输入中文名字 至少两个字";
    [_womanTextField setValue:[UIColor lightGrayColor] forKeyPath:@"_placeholderLabel.textColor"];
    [_womanTextField setValue:[UIFont systemFontOfSize:13.0] forKeyPath:@"_placeholderLabel.font"];
    _womanTextField.delegate=self;
    _womanTextField.layer.borderWidth = 0.5;
    _womanTextField.layer.borderColor = [UIColor blackColor].CGColor;
    _womanTextField.clipsToBounds =YES;
    _womanTextField.layer.cornerRadius = 6.0;
    _womanTextField.borderStyle = UITextBorderStyleNone;
    _womanTextField.font = [UIFont fontWithName:@"helvetica" size:14.0];
    _womanTextField.clearButtonMode = UITextFieldViewModeNever;//一键删除
    _womanTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;//垂直对其的方式
    _womanTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _womanTextField.keyboardType = UIKeyboardTypeDefault;
    _womanTextField.returnKeyType = UIReturnKeyDone;
    [_womanTextField becomeFirstResponder];//键盘第一响应
    [_womanTextField setSecureTextEntry:NO]; //隐藏字符
    [self.view addSubview:_womanTextField];
    
    _analysisBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _analysisBtn.backgroundColor = [UIColor purpleColor];
    _analysisBtn.titleLabel.font = [UIFont systemFontOfSize:22.0];
    [_analysisBtn setTitle:@"分   析" forState:UIControlStateNormal];
    [_analysisBtn setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
    [_analysisBtn setBackgroundColor:[UIColor orangeColor]];
    _analysisBtn.clipsToBounds = YES;
    _analysisBtn.layer.cornerRadius = 6.0;
    [_analysisBtn addTarget:self action:@selector(analysisBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_analysisBtn];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(100);
        make.left.mas_equalTo(self.view).offset(20);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(50);
    }];
    
    [self.manTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(50);
    }];
    
    [self.manTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(30);
        make.left.mas_equalTo(self.manTipLabel.mas_right).offset(2);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
    }];
    
    [self.womanTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.manTipLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(self.view).offset(20);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(50);

    }];
    [self.womanTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.manTextField.mas_bottom).offset(10);
        make.left.mas_equalTo(self.womanTipLabel.mas_right).offset(2);
        make.right.mas_equalTo(self.view).offset(-20);
        make.height.mas_equalTo(40);
    }];

    
    [self.analysisBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_womanTextField.mas_bottom).offset(30);
        make.left.mas_equalTo(self.view).offset(30);
        make.right.mas_equalTo(self.view).offset(-30);
        make.height.mas_equalTo(40);

    }];
    
    
}
-(void)analysisBtnClick{

    if ([_manTextField.text isEqualToString:@"Gorpeln"] || [_womanTextField.text isEqualToString:@"Gorpeln"] || [_manTextField.text isEqualToString:@""] || [_womanTextField.text isEqualToString:@""]) {
        UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"输入不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alertView show];
        
    }else{
        
        if (IsValidUserName(_manTextField.text) && IsValidUserName(_womanTextField.text)) {
            
            AVSpeechSynthesizer *av = [[AVSpeechSynthesizer alloc]init];
            AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc]initWithString:[NSString stringWithFormat:@"嗨。。大家注意了。%@喜欢%@。。%@喜欢%@。。",_manTextField.text,_womanTextField.text,_manTextField.text,_womanTextField.text]]; //需要转换的文本
            [av speakUtterance:utterance];
            [[MPMusicPlayerController applicationMusicPlayer] setVolume: 1.0];

        }else{
            
            UIAlertView *alertView =[[UIAlertView alloc] initWithTitle:@"提示" message:@"您的输入不合法" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
        }
    }
}


@end
