//
//  TeacherConfirmViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/26.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//

#import "TeacherConfirmViewController.h"
#import <Masonry.h>
#import <AFNetworking.h>
#import "SchoolList.h"
#import "GlobalVar.h"
#import "SchoolCreateClass.h"
#import "ELCImagePickerController.h"
#import <Photos/Photos.h>

@interface TeacherConfirmViewController () <UIPickerViewDataSource,UIPickerViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate>
@property (nonatomic,retain)UITextField* txName;
@property (nonatomic,retain)UITextField* txIdentity;
@property (nonatomic,retain)UIButton* identityFront;
@property (nonatomic,retain)UIButton* identityBack;
@property (nonatomic,retain)NSArray* classifyArray;
@property (nonatomic,retain)UIPickerView* pickerView;
@property (nonatomic,retain)UIView* pickerTopView;
@property (nonatomic,retain)NSNumber* cellTag;
@property (nonatomic,retain)NSString* sessionUrl;
@property (nonatomic,retain)NSDictionary* parameters;
@property (nonatomic,retain)NSDictionary* teacherParameters;
@property (nonatomic,retain)NSDictionary* pickerList;
@property (nonatomic,retain)NSArray* proTimeList;
@property (nonatomic,retain)NSArray* provinceArray;
@property (nonatomic,retain)NSArray* cityArray;
@property (nonatomic,retain)NSString* selectedCity;
@property (nonatomic,retain)NSDictionary* regionDict;
@property (nonatomic,retain)NSString* selectedClass;
@property (nonatomic,retain)NSArray* districtArray;
@property (nonatomic,retain)NSString* selectedDistrict;
@property (nonatomic,retain)NSArray* schoolArray;
@property (nonatomic,retain)NSArray* organizeClassArray;
@property (nonatomic,retain)NSString* selectedOrganizeClass;
@property (nonatomic,retain)UIButton* createClass;
@property (nonatomic,retain)SchoolList* selectedSchool;
@property (nonatomic,retain)SchoolCreateClass* schoolList;
@property (nonatomic,retain)NSNumber* identityProperty;


@end

@implementation TeacherConfirmViewController

-(void)initData{
    self.classifyArray = [GlobalVar classifyArrayGetter];
    self.regionDict = [GlobalVar regionDictGetter];
    self.provinceArray = [GlobalVar provinceArrayGetter];
}

-(void) uploadTeacherInfo {
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/teacher/add" ];
    
    self.teacherParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                              userid,@"uid",
                              userid, @"userId",
                              self.txName.text, @"name",
                              self.txIdentity.text,@"idnum",
                              [NSNumber numberWithInteger:self.selectedSchool.idField],@"schoolid",
                              nil];
    NSLog(@"%@", self.teacherParameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [session.requestSerializer  setValue:token forHTTPHeaderField:@"token"];     //将token添加到请求头
    [session         POST:self.sessionUrl
               parameters:self.teacherParameters
constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    UIImage *image1 = self.identityFront.imageView.image;
    NSData *data1 = UIImagePNGRepresentation(image1);
    UIImage *image2 = self.identityBack.imageView.image;
    NSData *data2 = UIImagePNGRepresentation(image2);
    //上传的参数(上传图片，以文件流的格式)
    [formData appendPartWithFileData:data1
                                name:@"files"
                            fileName:@"test.png"
                            mimeType:@"image/png"];
    [formData appendPartWithFileData:data2
                                name:@"files"
                            fileName:@"test.png"
                            mimeType:@"image/png"];
}
     
                 progress:nil
                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                      NSLog(@"%@",[responseObject class]);
                      //根据key获取value
                      NSNumber* status = [responseObject objectForKey:@"status"];
                      if ([status isEqualToNumber:[NSNumber numberWithInt:0]]) {
                          UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"申请成功，请等待审核"
                                                                                                   message:nil
                                                                                            preferredStyle:UIAlertControllerStyleAlert ];
                          UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定"
                                                                             style:UIAlertActionStyleDefault
                                                                           handler:^(UIAlertAction *action) {
                                                                               [self.navigationController popViewControllerAnimated:true];
                                                                           }];
                          [alertController addAction:OKAction];
                          [self presentViewController:alertController animated:true completion:nil];
                      }
                  }
                  failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                      NSLog(@"error%@",error);
                  }
     ];
    

}

-(void)didTouchIdentityBtn:(UIButton *)sender {
    NSLog(@"didtouchbtn");
    self.identityProperty = [NSNumber numberWithInteger:sender.tag];
    //UIAlertController风格：UIAlertControllerStyleAlert
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet ];
    
    //添加取消到UIAlertController中
    UIAlertAction *takingPhotoAction = [UIAlertAction actionWithTitle:@"拍摄"
                                                                style:UIAlertActionStyleDefault
                                                              handler:^(UIAlertAction *action) {
                                                                  [self getImageFromCamera];
                                                              }];
    [alertController addAction:takingPhotoAction];
    
    //添加确定到UIAlertController中
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"从相册中选择"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action) {
                                                         [self getImageFromIpc];
                                                     }];
    [alertController addAction:OKAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alertController addAction:cancelAction];


    [self presentViewController:alertController animated:true completion:nil];
}

- (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate  predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

-(void)getImageFromCamera {
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
    ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    // 照相机
    // ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
    // 4.设置代理
    ipc.delegate = self;
    // 5.modal出这个控制器
    [self presentViewController:ipc animated:YES completion:nil];

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
    if ([self.identityProperty isEqualToNumber:[NSNumber numberWithInteger:self.identityFront.tag]]) {
        [self.identityFront setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    } else if ([self.identityProperty isEqualToNumber:[NSNumber numberWithInteger:self.identityBack.tag]]) {
        [self.identityBack setImage:info[UIImagePickerControllerOriginalImage] forState:UIControlStateNormal];
    }
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

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.txIdentity resignFirstResponder];
    [self.txName resignFirstResponder];
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initData];

    self.view.backgroundColor = [GlobalVar grayColorGetter];
    
    [self initNaigationBar];
    //nameview
    UIView* nameView = [UIView new];
    nameView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameView];
    UILabel* nameLabel = [UILabel new];
    nameLabel.text = @"姓名";
    nameLabel.textAlignment = NSTextAlignmentCenter;
    self.txName = [UITextField new];
    self.txName.placeholder = @"请输入您的真实姓名";
    self.txName.delegate = self;
    [nameView addSubview:nameLabel];
    [nameView addSubview:self.txName];
//    self.txName.placeholder = @"请输入您的真实姓名";
    
    //identityView
    UIView* identityView = [UIView new];
    identityView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:identityView];
    UILabel* identityLabel = [UILabel new];
    identityLabel.text = @"身份证号";
    identityLabel.textAlignment = NSTextAlignmentCenter;
    self.txIdentity = [UITextField new];
    self.txIdentity.placeholder = @"请输入您的身份证号";
    self.txIdentity.delegate = self;
    [identityView addSubview:identityLabel];
    [identityView addSubview:self.txIdentity];

    
    //identityCardImageView
    UIView* identityImageView = [UIView new];
    identityImageView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:identityImageView];
    UILabel* identityImageLabel = [UILabel new];
    identityImageLabel.textAlignment = NSTextAlignmentCenter;
    identityImageLabel.text = @"请按照范例上传身份证正反面照片";
    [identityImageView addSubview:identityImageLabel];
    self.identityFront = [UIButton new];
    self.identityBack = [UIButton new];
    [identityImageView addSubview:self.identityBack];
    [identityImageView addSubview:self.identityFront];
    [self.identityFront setImage:[UIImage imageNamed:@"identityImageFront.jpeg"] forState:UIControlStateNormal];
    [self.identityBack setImage:[UIImage imageNamed:@"identityImageBack.jpeg"] forState:UIControlStateNormal];
    [self.identityFront setTag:66];
    [self.identityFront addTarget:self action:@selector(didTouchIdentityBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.identityBack setTag:88];
    [self.identityBack addTarget:self action:@selector(didTouchIdentityBtn:) forControlEvents:UIControlEventTouchUpInside];

    
//    NSArray* views = [self.view subviews];
//    for (UILabel *view in views) {
//        if ([view class] == [UILabel class]) {
//            view.textAlignment = NSTextAlignmentCenter;
//        }
//    }
//    
    
    
    [nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(44);
        make.centerX.equalTo(self.view);
    }];
    
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(nameView).offset(15);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(nameView);
    }];
    
    [self.txName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.txIdentity);
        make.right.equalTo(self.view.mas_right).offset(-30);
        make.centerY.equalTo(nameView);
    }];
    
    [identityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameView.mas_bottom).offset(1);
        make.width.equalTo(self.view);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [identityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(identityView).offset(15);
        make.width.mas_equalTo(70);
        make.centerY.equalTo(identityView);
    }];
    
    [self.txIdentity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(identityLabel.mas_right).offset(33);
        make.right.equalTo(identityView).offset(-30);
        make.height.equalTo(identityLabel);
        make.centerY.equalTo(identityView);
    }];
    
    [identityImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityView.mas_bottom).offset(1);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(150);
    }];
    
    [identityImageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityImageView).offset(10);
        make.width.equalTo(self.view);
        make.height.mas_equalTo(20);
        make.centerX.equalTo(self.view);
    }];
    
    [self.identityFront mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityImageLabel.mas_bottom).offset(10);
        make.left.equalTo(identityImageView).offset(15);
        make.width.equalTo(self.identityBack);
        make.right.equalTo(self.identityBack.mas_left).offset(-10);
        make.bottom.equalTo(identityImageView).offset(-10);
    }];
    
    [self.identityBack mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityImageLabel.mas_bottom).offset(10);
        make.right.equalTo(identityImageView).offset(-15);
        make.width.equalTo(self.identityFront);
        make.left.equalTo(self.identityFront.mas_right).offset(10);
        make.bottom.equalTo(identityImageView).offset(-10);
    }];

    UIView* chooseSchoolView = [UIView new];
    [self.view addSubview:chooseSchoolView];
    UILabel* chooseSchoolLabel = [UILabel new];
    chooseSchoolLabel.textAlignment = NSTextAlignmentCenter;
    chooseSchoolLabel.text = @"选择学校";
    [chooseSchoolView addSubview:chooseSchoolLabel];
    [chooseSchoolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(identityImageView.mas_bottom).offset(10);
        make.width.equalTo(self.view);
        make.left.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    [chooseSchoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chooseSchoolView).offset(15);
        make.centerY.equalTo(chooseSchoolView);
        make.height.width.equalTo(identityLabel);
    }];
    
    
    self.cityView = [CreateClassSubView new];
    self.kindView = [CreateClassSubView new];
    self.areaView = [CreateClassSubView new];
    self.organizeView = [CreateClassSubView new];
    
    
    self.cityView.key = @"城市";
    self.cityView.value = @"杭州";
    [self.cityView setTag:4];
    self.cityView.backgroundColor = [UIColor whiteColor];
    [self.cityView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.kindView.key= @"类型";
    self.kindView.value = [self.classifyArray objectAtIndex:0];
    self.kindView.backgroundColor = [UIColor whiteColor];
    [self.kindView setTag:5];
    [self.kindView addTarget:self action:@selector(didTouchBtn:) forControlEvents: UIControlEventTouchUpInside];
    
    self.areaView.key = @"地区";
    self.areaView.value = @"江干区";
    [self.areaView setTag:6];
    self.areaView.backgroundColor = [UIColor whiteColor];
    [self.areaView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    

    self.organizeView.key = @"学校";

    [self.organizeView setTag:7];
    self.organizeView.backgroundColor = [UIColor whiteColor];
    [self.organizeView addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.cityView];
    [self.view addSubview:self.kindView];
    [self.view addSubview:self.areaView];
    [self.view addSubview:self.organizeView];
    
    [self.cityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.width.equalTo(self.view.mas_width);
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(chooseSchoolView.mas_bottom).offset(1);
    }];
    
    [self.kindView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.cityView.mas_bottom).offset(1);
    }];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.kindView.mas_bottom).offset(1);
    }];
    
    [self.organizeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(44);
        make.left.equalTo(self.view.mas_left);
        make.width.equalTo(self.view.mas_width);
        make.top.equalTo(self.areaView.mas_bottom).offset(1);
    }];

    UIButton* confirmButton = [UIButton new];
    [self.view addSubview:confirmButton];
    [confirmButton setTitle:@"认证教师" forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setBackgroundColor:[GlobalVar themeColorGetter]];
    confirmButton.layer.cornerRadius = 5;
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.organizeView.mas_bottom).offset(10);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(280);
        make.height.mas_equalTo(44);
    }];
    [confirmButton setTag:52];
    [confirmButton addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)popPickerView
{
    self.pickerView = [UIPickerView new];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.backgroundColor = [UIColor whiteColor];
    self.pickerView.alpha = 1;
    [self.view addSubview:self.pickerView];
    
    self.pickerTopView = [UIView new];
    self.pickerTopView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.pickerTopView];
    [self.pickerTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.pickerView.mas_top);
        make.height.mas_equalTo(30);
        make.width.equalTo(self.view.mas_width);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
    //here it is
    UIButton* leftBtn = [[UIButton alloc] init];
    UIButton* rightBtn = [UIButton new];
    [leftBtn setTitle:@"取消" forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [leftBtn setTag:2];
    [leftBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [rightBtn setTag:3];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(didTouchBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.pickerTopView addSubview:leftBtn];
    [self.pickerTopView addSubview:rightBtn];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.equalTo(self.pickerTopView.mas_height);
        make.left.equalTo(self.pickerTopView.mas_left).offset(5);
        make.centerY.equalTo(self.pickerTopView.mas_centerY);
    }];
    
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.equalTo(self.pickerTopView.mas_height);
        make.right.equalTo(self.pickerTopView.mas_right).offset(-5);
        make.centerY.equalTo(self.pickerTopView.mas_centerY);
        
    }];
    
    
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom);
        make.width.equalTo(self.view.mas_width);
        make.height.mas_equalTo(150);
        make.centerX.equalTo(self.view.mas_centerX);
    }];
}

#pragma Mark-- UIPickerViewDataSource
//pickerview 列数

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        return 2;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        return 1;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return 1;
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        return 1;
    }
    
    return 0;
}

//pickerview 每列的行数
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            return [self.provinceArray count];
        }
        NSInteger row=[self.pickerView selectedRowInComponent:0];
        return [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:row]] count];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
        return [self.classifyArray count];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return [self.districtArray count];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        return [self.schoolArray count];
    }
    
    return 0;
    
    
}

#pragma Mark -- UIPickerViewDelegate
// 每列宽度
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]] ) {
        return  self.view.bounds.size.width / 2;
    } else {
        return self.view.bounds.size.width-20;
    }
}
// 返回选中的行
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            [self.pickerView reloadComponent:1];
            self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:row]] objectAtIndex:0];
            
        } else {
            
            NSInteger firstRow=[self.pickerView selectedRowInComponent:0];
            self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:firstRow]] objectAtIndex:row];
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {
            self.selectedClass = [self.classifyArray objectAtIndex:row];
        
        
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        self.selectedDistrict = [self.districtArray objectAtIndex:row];
        NSLog(@"%@", self.selectedDistrict);
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]]) {
        self.selectedSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:row]];
    }
    
}

//返回当前行的内容,此处是将数组中数值添加到滚动的那个显示栏上
-(NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]])
    {
        if (component == 0) {
            return [self.provinceArray objectAtIndex:row];
        } else {
            NSInteger firstRow=[self.pickerView selectedRowInComponent:0];
            return [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:firstRow]] objectAtIndex:row];
            
        }
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]])
    {

            return [self.classifyArray objectAtIndex:row];

    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]])
    {
        return [self.districtArray objectAtIndex:row];
    }
    if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]])
    {
        SchoolList *pickerSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:row]];
        return pickerSchool.school;
    }
    
    
    
    return @"";
}



-(void)didTouchBtn:(UIButton *)sender{
    if(sender.tag == 2)
    {
        NSLog(@"取消");
        self.pickerView.hidden = true;
        self.pickerTopView.hidden = true;
        
    }
    if (sender.tag == 3) {
        NSLog(@"完成");
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.cityView.tag]]) {
            self.cityView.value = self.selectedCity;\

        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.kindView.tag]]) {
            

                self.kindView.value = self.selectedClass;
                [self downloadDistrict];
            
            
        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.areaView.tag]]) {
            self.areaView.value = self.selectedDistrict;
            [self downloadSchool];
            
        }
        if ([self.cellTag isEqualToNumber:[NSNumber numberWithInteger:self.organizeView.tag]]) {
            self.organizeView.value = self.selectedSchool.school;
        }
        [self updateUI];
        self.pickerView.hidden = true;
        self.pickerTopView.hidden = true;
        
    }
    if (sender.tag == self.cityView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.selectedCity = [[self.regionDict objectForKey:[self.provinceArray objectAtIndex:0]] objectAtIndex:0];
    }
    if (sender.tag == self.kindView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.kindView.value = [self.classifyArray objectAtIndex:0];
    }
    if (sender.tag == self.areaView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        self.areaView.value = [self.districtArray objectAtIndex:0];
        
    }
    if (sender.tag == self.organizeView.tag) {
        self.cellTag = [NSNumber numberWithInteger:sender.tag];
        [self popPickerView];
        
        //这里要进行进程控制
        
        
        
        
        
        
        self.selectedCity = [self.schoolArray objectAtIndex:0];
    }
    
    if (sender.tag == 52) {
        if (![self validateIdentityCard:self.txIdentity.text]) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请输入正确的身份证号"
                                                                                     message:nil
                                                                              preferredStyle:UIAlertControllerStyleAlert ];
            UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确定"
                                                               style:UIAlertActionStyleDefault
                                                             handler:nil];
            [alertController addAction:OKAction];
            [self presentViewController:alertController animated:true completion:nil];

        } else {
            [self uploadTeacherInfo];
        }
    }
    

}


-(void)downloadDistrict
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSNumber* userid = [defaults objectForKey:@"uid"];
    NSString* token = [defaults objectForKey:@"token"];
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/school/qth" ];

        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid,@"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:self.kindView.value]],@"classify",
                           self.cityView.value,@"city",
                           nil];
    
    NSLog(@"%@", self.parameters);
    
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    [session.requestSerializer setValue:token forHTTPHeaderField:@"token"];
    [session GET:self.sessionUrl parameters:self.parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success");
        NSNumber* status = [responseObject objectForKey:@"status"];
        if ([status isEqualToNumber:[NSNumber numberWithInteger:0]] ) {

                self.districtArray = [responseObject objectForKey:@"list"];
                self.selectedDistrict = [self.districtArray objectAtIndex:0];
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@", error);
    }];
}

-(void)downloadSchool
{
    NSUserDefaults *defaults =[NSUserDefaults standardUserDefaults];
    NSString *token = [defaults objectForKey:@"token"];//根据键值取出name
    NSNumber *userid = [defaults objectForKey:@"uid"];
    NSLog(@"%@", userid);
    
    self.sessionUrl = [NSString stringWithFormat:@"%@%@%@",@"http://",[GlobalVar urlGetter], @"/bjquan/school/qschool" ];
    

        self.parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                           userid, @"userId",
                           [NSNumber numberWithInteger:[self.classifyArray indexOfObject:self.kindView.value]], @"classify",
                           self.cityView.value,@"city",
                           self.areaView.value,@"area",
                           nil];
        
    AFHTTPSessionManager* session = [AFHTTPSessionManager manager];
    
    session.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [session.requestSerializer  setValue:token forHTTPHeaderField:@"token"];     //将token添加到请求头
    [session GET:self.sessionUrl parameters:self.parameters progress:nil
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSLog(@"%@",[responseObject class]);
             //根据key获取value
             NSNumber* status = [responseObject objectForKey:@"status"];
             if ([status isEqualToNumber:[NSNumber numberWithInt:0]]) {
                 NSLog(@"success");
                 
                 NSLog(@"school: %@", self.schoolList);
                 self.schoolArray = [responseObject objectForKey:@"list"];
                 self.selectedSchool = [[SchoolList alloc] initWithDictionary:[self.schoolArray objectAtIndex:0]];
             }
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             NSLog(@"error%@",error);
         }
     ];
    
}
-(void)updateUI
{

    self.organizeView.key = @"学校";

    [self.organizeView.lbkey setHidden:true];
    [self.organizeView.lbvalue setHidden:true];
    
    [self.cityView.lbkey setHidden:true];
    [self.cityView.lbvalue setHidden:true];
    
    [self.kindView.lbvalue setHidden:true];
    [self.kindView.lbkey setHidden:true];
    
    [self.areaView.lbvalue setHidden:true];
    [self.areaView.lbkey setHidden:true];
    
    [self.organizeView drawRect:self.organizeView.bounds];
    [self.cityView drawRect:self.cityView.bounds];
    [self.kindView drawRect:self.kindView.bounds];
    [self.areaView drawRect:self.areaView.bounds];
    
}

-(void)initNaigationBar
{
    self.title = @"教师认证";
    
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }

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
