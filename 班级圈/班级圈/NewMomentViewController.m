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

@interface NewMomentViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, ELCImagePickerControllerDelegate>
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSMutableArray* classes;
@property (nonatomic,retain)NSMutableArray* imageArray;
@end

@implementation NewMomentViewController

- (void)showImagePicker{
    ELCImagePickerController *imagePicker = [[ELCImagePickerController alloc] initImagePicker];
    imagePicker.maximumImagesCount = 9;
    imagePicker.returnsOriginalImage = YES;
    imagePicker.returnsImage = YES;
    imagePicker.onOrder = YES;
    imagePicker.mediaTypes = @[(NSString *)kUTTypeImage];
    imagePicker.imagePickerDelegate = self;
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

#pragma mark - imagePickerController 代理
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerOriginalImage]) {
            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            // 压缩图片
//            UIImage *resizedImage = [image compressImage:300];
            [self.imageArray addObject:image];
        }
    }
//    [self.imageCollectionView reloadData];
}

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
    [session                    POST:self.sessionUrl
                          parameters:self.parameters
           constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
               UIImage *image = self.chooseImageBtn.imageView.image;
               NSData *data = UIImagePNGRepresentation(image);
               //上传的参数(上传图片，以文件流的格式)
               [formData appendPartWithFileData:data
                                           name:@"files"
                                       fileName:@"test.png"
                                       mimeType:@"image/png"];
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
    if (sender.tag == self.chooseImageBtn.tag) {
        [self getImageFromIpc];
    }
}
- (void)getImageFromIpc
{
    // 1.判断相册是否可以打开
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
    // 2. 创建图片选择控制器
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    /**
     typedef NS_ENUM(NSInteger, UIImagePickerControllerSourceType) {
     UIImagePickerControllerSourceTypePhotoLibrary, // 相册
     UIImagePickerControllerSourceTypeCamera, // 用相机拍摄获取
     UIImagePickerControllerSourceTypeSavedPhotosAlbum // 相簿
     }
     */
    // 3. 设置打开照片相册类型(显示所有相簿)
    ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];
}
#pragma mark -- <UIImagePickerControllerDelegate>--
// 获取图片后的操作
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    // 销毁控制器
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 设置图片
    [self.chooseImageBtn setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
}
- (void)getOriginalImages
{
    // 获得所有的自定义相簿
    PHFetchResult<PHAssetCollection *> *assetCollections = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    // 遍历所有的自定义相簿
    for (PHAssetCollection *assetCollection in assetCollections) {
        [self enumerateAssetsInAssetCollection:assetCollection original:YES];
    }
    
    // 获得相机胶卷
    PHAssetCollection *cameraRoll = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeSmartAlbumUserLibrary options:nil].lastObject;
    // 遍历相机胶卷,获取大图
    [self enumerateAssetsInAssetCollection:cameraRoll original:YES];
}

/**
 *  遍历相簿中的所有图片
 *  @param assetCollection 相簿
 *  @param original        是否要原图
 */
- (void)enumerateAssetsInAssetCollection:(PHAssetCollection *)assetCollection original:(BOOL)original
{
    NSLog(@"相簿名:%@", assetCollection.localizedTitle);
    
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
    // 同步获得图片, 只会返回1张图片
    options.synchronous = YES;
    
    // 获得某个相簿中的所有PHAsset对象
    PHFetchResult<PHAsset *> *assets = [PHAsset fetchAssetsInAssetCollection:assetCollection options:nil];
    for (PHAsset *asset in assets) {
        // 是否要原图
        CGSize size = original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;
        
        // 从asset中获得图片
        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"%@", result);
        }];
    }
}

-(void)createUI
{
    self.txText = [UITextView new];
    self.txText.text = @"来分享点什么吧....";
    self.txText.font = [UIFont systemFontOfSize:17];
    //    self.txText.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.txText];
    [self.txText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(15);
        make.height.mas_equalTo(134.5);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
        
    }];
    
    self.chooseImageBtn = [UIButton new];
    [self.chooseImageBtn setImage:[UIImage imageNamed:@"plus"] forState:UIControlStateNormal];
    [self.chooseImageBtn setTag:50];
    [self.chooseImageBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chooseImageBtn];
    [self.chooseImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.txText.mas_bottom).offset(10);
        make.left.equalTo(self.view.mas_left).offset(15);
        make.height.width.mas_equalTo(100);
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
