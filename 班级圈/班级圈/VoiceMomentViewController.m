//
//  VoiceMomentViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/29.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "VoiceMomentViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Masonry.h>

@interface VoiceMomentViewController ()
@property (nonatomic,retain)AVAudioRecorder* recorder;
@property (nonatomic,retain)AVAudioPlayer* player;
@property (nonatomic,retain)AVAudioSession* session;
@property (nonatomic,retain)NSURL* recordFileUrl;
@property (nonatomic,retain)UIImageView* backgroundImage;
@end

@implementation VoiceMomentViewController

- (IBAction)startRecord:(id)sender {
    NSLog(@"开始录音");
    

    self.session =[AVAudioSession sharedInstance];
    NSError *sessionError;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    
    if (self.session == nil) {
        
        NSLog(@"Error creating session: %@",[sessionError description]);
        
    }else{
        [self.session setActive:YES error:nil];
        
    }
//    self.session = session;
    //1.获取沙盒地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString* filePath = [path stringByAppendingString:@"/RRecord.wav"];
    
    //2.获取文件路径
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   //采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 8000.0],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   //采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   //录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,
                                   nil];
    
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:nil];
    
    if (_recorder) {
        
        _recorder.meteringEnabled = YES;
        [_recorder prepareToRecord];
        [_recorder record];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(60 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self stopRecord:nil];
        });
    }else{
        NSLog(@"音频格式和文件存储格式不匹配,无法初始化Recorder");
    }
}

- (IBAction)stopRecord:(id)sender {
    
    NSLog(@"停止录音");
    
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
    

}

- (IBAction)PlayRecord:(id)sender {
    
    NSLog(@"播放录音");
    [self.recorder stop];
    
    if ([self.player isPlaying])return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:nil];
    NSLog(@"%li",self.player.data.length/1024);
    [self.session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [self.player play];
}

-(void)createUI
{
    UIView* bottomView = [UIView new];
    [self.view addSubview:bottomView];
    bottomView.backgroundColor = [UIColor blackColor];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.centerX.equalTo(self.view);
        make.height.mas_equalTo(self.view.bounds.size.height*0.4);
    }];
    
    UIButton* audioBtn = [UIButton new];
    [bottomView addSubview:audioBtn];
    UIImage* image = [UIImage imageNamed:@"audio.jpeg"];
    [audioBtn setImage:image forState:UIControlStateNormal];
    [audioBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bottomView);
        make.width.height.mas_equalTo(100);
        
    }];
    [audioBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchDown];
    [audioBtn addTarget:self action:@selector(startRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backgroundImage = [UIImageView new];
    self.backgroundImage.image = [UIImage imageNamed:@"test1.jpeg"];
    [self.view addSubview:self.backgroundImage];
    [self.backgroundImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.top.equalTo(self.view);
        make.height.mas_equalTo(self.view.bounds.size.height*0.6);
    }];
    self.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
//    [backgroundImage setImageToBlur: [UIImage imageNamed:@"huoying4.jpg"] blurRadius:20 completionBlock:nil];
    self.backgroundImage.userInteractionEnabled = YES;
    /*
       9    毛玻璃的样式(枚举)
       10    UIBlurEffectStyleExtraLight,
       11    UIBlurEffectStyleLight,
       12    UIBlurEffectStyleDark
       13    */
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:true];
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleRegular];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.backgroundImage.frame;
    [self.backgroundImage addSubview:effectView];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
