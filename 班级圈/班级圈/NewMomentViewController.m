//
//  NewMomentViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/23.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "NewMomentViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "GlobalVar.h"
#import "SelectClassViewController.h"
#import <Photos/Photos.h>
#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>

@interface NewMomentViewController () <UIImagePickerControllerDelegate, ELCImagePickerControllerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSMutableArray* classes;
@property (nonatomic,retain)NSMutableArray* imageArray;
@end

@implementation NewMomentViewController

-(void)uploadMoment
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/title/post" ];
        //创建多个字典
        NSString* subParameter = [[NSString alloc] init];
        for (int i = 0; i < [self.selectedClasses count]; i++) {
            if (i == 0) {
                subParameter = [NSString stringWithFormat:@"%@",[self.selectedClasses objectAtIndex:i]];
            } else  {
                subParameter = [NSString stringWithFormat:@"%@,%@",subParameter,[self.selectedClasses objectAtIndex:i]];
            }
            
        }
        
        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid,@"userId",
                           userid,@"userid",
                           self.txText.text,@"content",
                           subParameter,@"classIds",
                           nil];
        
        NSLog(@"parameters :%@", self.parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session                POST:self.sessionUrl
                          parameters:self.parameters
           constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
               for (int i = 0; i< [self.imageArray count]; i++ ) {
                   NSData *data = UIImagePNGRepresentation([self.imageArray objectAtIndex:i]);
                   //上传的参数(上传图片，以文件流的格式)
                   [formData appendPartWithFileData:data
                                               name:@"files"
                                           fileName:@"test.png"
                                           mimeType:@"image/png"];
               }
               
           } progress:^(NSProgress * _Nonnull uploadProgress) {
               
           } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
               NSLog(@"上传成功");
           } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
               NSLog(@"上传失败%@",error);
           }];
    }
}


-(void)downloadClass
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    if (userid) {
        self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @":8080/bjquan/class/quclass" ];
        //创建多个字典
        self.parameters = [NSDictionary dictionaryWithObject:userid forKey:@"userId"];
        
        NSLog(@"parameters :%@", self.parameters);
        
        AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
        session.responseSerializer = [AFJSONResponseSerializer serializer];

        [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
        [session GET:self.sessionUrl
          parameters:self.parameters 
            progress:nil
             success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  NSLog(@"%@",responseObject);
                  //根据key获取value
                  NSNumber* status = [responseObject objectForKey:@"status"];
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:2]]) {
                      NSLog(@"success");
                      //UIAlertController风格：UIAlertControllerStyleAlert
                      UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"出错啦！暂时无法发布动态啦！"
                                                                                               message:@""
                                                                                        preferredStyle:UIAlertControllerStyleAlert ];
                      
                      //添加取消到UIAlertController中
                      UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
                      [alertController addAction:cancelAction];
                      
                      //添加确定到UIAlertController中
                      UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
                      [alertController addAction:OKAction];
                      
                      [self presentViewController:alertController animated:YES completion:nil];
                  }
                  
                  if ([status isEqualToNumber:[NSNumber numberWithInteger:0]]) {
                      
                      self.classes = [responseObject objectForKey:@"classes"];
                      NSLog(@"%@", self.classes);
                  }
                  
              }
              failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                  NSLog(@"failure");
                  NSLog(@"%@", error);
              }
         ];
    }
    
}


-(void)didTouchBtn:(UIButton* )sender
{
    if (sender.tag == self.chooseClass.tag) {
        SelectClassViewController* selectClassVC = [[SelectClassViewController alloc] init];
        selectClassVC.classes = self.classes;
        [self.navigationController pushViewController:selectClassVC animated:true];
    }
}

- (IBAction)selectPhoto:(id)sender
{
    UIActionSheet *_sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"打开照相机", @"从相册中获取", nil];
    
    [_sheet showInView:self.view];
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    switch (buttonIndex) {
        case 0:
            //选择照相机
            [self takePhoto];
            break;
        case 1:
            //选择相册
            [self LocalPhoto];
            break;
        default:
            break;
    }
}

- (void)takePhoto
{
    UIImagePickerControllerSourceType sourcType = UIImagePickerControllerSourceTypeCamera;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.sourceType = sourcType;
        [self presentViewController:picker animated:YES completion:^{
            
        }];
        
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"无法调取相机，请检查" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        return;
    }
    
}

- (void)LocalPhoto
{
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    
    elcPicker.maximumImagesCount = 9; //选择图像的最大数量设置为9
    elcPicker.returnsOriginalImage = YES; //只返回fullScreenImage,不是fullResolutionImage
    elcPicker.returnsImage = YES; //如果是的 返回UIimage。如果没有,只返回资产位置信息
    elcPicker.onOrder = YES; //对多个图像选择、显示和返回的顺序选择图像
    elcPicker.mediaTypes = @[(NSString *)kUTTypeImage]; //支持图片和电影类型
    
    elcPicker.imagePickerDelegate = self;
    
    [self presentViewController:elcPicker animated:YES completion:nil];
    
    
}

-(void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    
}

//相册
- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                //把图片取出来放到数组里面
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [self.imageArray addObject:image];
            }
            
        }else {
            // NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        }
    }
//    self.imageView.image = array[0];
//    self.imageView1.image = array[1];
    [self updateUI:self.imageArray];
    
}

-(void)updateUI:(NSArray *)imageArray
{
    CGFloat width = (self.view.bounds.size.width - 60) / 3;
    if ([imageArray count]<=3) {
        for (int i = 0; i < [imageArray count]; i++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10);
                make.left.equalTo(self.view.mas_left).offset(15+i*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        if ([imageArray count] == 3) {
            [self.chooseImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(15);
                make.top.equalTo(self.txText.mas_bottom).offset(10+10+width);
            }];
        } else {
            [self.chooseImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(15+[imageArray count]*(15+width));
            }];
        }
    } else if ([imageArray count] <= 6) {
        for (int i = 0; i < 3 ; i ++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10);
                make.left.equalTo(self.view.mas_left).offset(15+i*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        for (int i =3; i < [imageArray count]; i++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10+10+width);
                make.left.equalTo(self.view.mas_left).offset(15+(i-3)*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        if ([imageArray count] == 6) {
            [self.chooseImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view.mas_left).offset(15);
                make.top.equalTo(self.txText.mas_bottom).offset(10+2*(10+width));
            }];
        } else {
            [self.chooseImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10+10+width);
                make.left.equalTo(self.view.mas_left).offset(15+([imageArray count]-3)*(15+width));
            }];
        }
    } else if ([imageArray count] <= 9) {
        for (int i = 0; i < 3 ; i ++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10);
                make.left.equalTo(self.view.mas_left).offset(15+i*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        for (int i =3; i < 6; i++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10+10+width);
                make.left.equalTo(self.view.mas_left).offset(15+(i-3)*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        for (int i = 6; i < [imageArray count]; i ++) {
            UIButton* imageBtn = [UIButton new];
            [self.view addSubview:imageBtn];
            [imageBtn setImage:imageArray[i] forState:UIControlStateNormal];
            [imageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10+2*(10+width));
                make.left.equalTo(self.view.mas_left).offset(15+(i-6)*(15+width));
                make.width.height.mas_equalTo(width);
            }];
        }
        if ([imageArray count] == 9) {
            [self.chooseImageBtn setHidden:true];
        } else {
            [self.chooseImageBtn mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.txText.mas_bottom).offset(10+2*(10+width));
                make.left.equalTo(self.view.mas_left).offset(15+([imageArray count]-6)*(15+width));
            }];
        }
    }
}

#pragma mark - 照片选择代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 1. 获取编辑后的照片
    UIImage *image;
    switch (picker.sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
            image = info[@"UIImagePickerControllerOriginalImage"];
            //将图片保存到相册
            [self saveImageToPhotos:image];
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
            image = info[@"UIImagePickerControllerEditedImage"];
            break;
        default:
            break;
    }
//    // 2. 设置按钮的图像
//    self.imageView.image = image;
    
    // 3. 关闭照片选择控制器
    [self dismissViewControllerAnimated:YES completion:nil];
}

//将图片保存到相册
- (void)saveImageToPhotos:(UIImage*)savedImage

{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示" message:msg delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
}


-(void)createUI
{
    
    CGFloat width = (self.view.bounds.size.width - 60) / 3;

    self.txText = [UITextView new];
    self.txText.text = @"来分享点什么吧....";
    self.txText.font = [UIFont systemFontOfSize:17];
    //    self.txText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.txText];
    [self.txText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.height.mas_equalTo(120);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        
    }];
    
    self.chooseImageBtn = [UIButton new];
    [self.chooseImageBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [self.chooseImageBtn setTag:50];
    [self.chooseImageBtn addTarget:self action:@selector(selectPhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseImageBtn];
    [self.chooseImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txText.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.width.mas_equalTo(width);
    }];
    
    self.chooseClass = [UIButton new];
    [self.chooseClass addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseClass setTag:1];
    [self.view addSubview:self.chooseClass];
    [self.chooseClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chooseImageBtn.mas_bottom).offset(20);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(44);
    }];
    UILabel* lbChooseClass = [UILabel new];
    lbChooseClass.text = @"选择发送到的班级圈";
    UIImageView* chooseClassImg = [UIImageView new];
    [chooseClassImg setImage:[UIImage imageNamed:@"GLOBE"]];
    [self.chooseClass addSubview:chooseClassImg];
    [self.chooseClass addSubview:lbChooseClass];

    UIView* view1 = [UIView new];
    view1.backgroundColor = [UIColor grayColor];
    UIView* view2 = [UIView new];
    view2.backgroundColor = [UIColor grayColor];
    
    [self.chooseClass addSubview:view1];
    [self.chooseClass addSubview:view2];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.chooseClass.mas_top);
        make.width.equalTo(self.chooseClass);
        make.height.mas_equalTo(1);
        make.left.equalTo(self.chooseClass);
    }];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.chooseClass.mas_bottom);
        make.width.equalTo(self.chooseClass.mas_width);
        make.left.equalTo(self.chooseClass.mas_left);
        make.height.mas_equalTo(1);
    }];
    
    UIImageView* arrowImg = [UIImageView new];
    [arrowImg setImage:[UIImage imageNamed:@"ARROW_RIGHT拷贝"]];
    [self.chooseClass addSubview:arrowImg];
    UILabel* lbSelectedClass = [UILabel new];
    lbSelectedClass.text = @"所有班级";
    lbSelectedClass.font = [UIFont systemFontOfSize:15];
    lbSelectedClass.textColor = [UIColor grayColor];
    [self.chooseClass addSubview:lbSelectedClass];
    
    [lbSelectedClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(arrowImg.mas_left).offset(-5);
        make.centerY.equalTo(self.chooseClass.mas_centerY);
    }];
    
    
    [arrowImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.chooseClass.mas_right).offset(-15);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(13);
        make.centerY.equalTo(self.chooseClass.mas_centerY);
    }];
    
    [lbChooseClass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseClassImg.mas_right).offset(10);
        make.centerY.equalTo(self.chooseClass.mas_centerY);
        make.right.equalTo(arrowImg).offset(-20);
    }];
    
    [chooseClassImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.chooseClass).offset(20);
        make.centerY.equalTo(self.chooseClass);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(22);
        
    }];
    
    
    
}

-(void)didTouchBarButtonItem
{
    [self uploadMoment];
}

-(void)initNavigation
{
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.imageArray = [NSMutableArray array];
    [self downloadClass];
    self.selectedClasses = [[NSMutableArray alloc] init];
    self.title = @"动态";
    self.view.backgroundColor = [UIColor whiteColor];
    [self initNavigation];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(didTouchBarButtonItem)];
    
    
    
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
