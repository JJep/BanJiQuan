//
//  ViewController.m
//  班级圈
//
//  Created by Jep Xia on 2017/4/29.
//  Copyright © 2017年 Jep Xia. All rights reserved.
//
#import "ViewController.h"
#import "ELCImagePickerController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/UTCoreTypes.h>
#import <Masonry.h>
@interface ViewController ()<UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate,ELCImagePickerControllerDelegate>
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *imageView1;

@end

@implementation ViewController
- (UIImageView *)imageView
{
    if (!_imageView) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 64 , 200, 200)];
        //  [_imageView setContentMode:UIViewContentModeScaleAspectFit];
        _imageView.layer.cornerRadius = 100;
        _imageView.clipsToBounds = YES;
        [self.view addSubview:_imageView];
    }
    return _imageView;
}
- (UIImageView *)imageView1
{
    if (!_imageView1) {
        self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(100, 364 , 200, 200)];
        _imageView1.layer.cornerRadius = 100;
        _imageView1.clipsToBounds = YES;
        [self.view addSubview:_imageView1];
    }
    return _imageView1;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    
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
    
    NSMutableArray *array = [NSMutableArray array];
    [array removeAllObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
    NSLog(@"%@", info);
    for (NSDictionary *dict in info) {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                //把图片取出来放到数组里面
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                [array addObject:image];
            }
            
        }else {
            // NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
        }
    }
    self.imageView.image = array[0];
    self.imageView1.image = array[1];
    
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
    // 2. 设置按钮的图像
    self.imageView.image = image;
    
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
@end
