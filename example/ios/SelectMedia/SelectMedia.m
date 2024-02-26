//
//  SelectMedia.m
//  Runner
//
//  Created by hello on 2024/2/7.
//

#import "SelectMedia.h"

@implementation SelectMedia

// 回调到flutter的方法名称
NSString *callbackName = @"_selectMediaCallbackName";
// 视屏回调名称
NSString *videoMsgName = @"video/mp4";
// 图片回调名称
NSString *imageMsgName = @"image/jpeg";


/**
 文件选择函数
 */
- (void)selectMedia:(FlutterMethodChannel *)methodChannel withMediaType:(NSNumber *)mediaType withLength:(NSNumber *)maxLength withSecond:(NSNumber *)maxSecond{
    
    // 初始化文件选择器
    TZImagePickerController *selectController = [[TZImagePickerController alloc] initWithMaxImagesCount:[maxLength intValue] delegate:self];
    // 设置选择视频的最大时长
    selectController.videoMaximumDuration = [maxSecond intValue];
    
    // 弹窗模式、先默认全屏
    selectController.modalPresentationStyle = UIModalPresentationFullScreen;
    // 进行文件选择类型判断
    [self selectTypeHandle:selectController withMediaType:mediaType];
    // 湖区 UIView
    UIViewController *viewController = [[ViewControllerUtils alloc] getCurrentVc];
    
    // 视频选择回调
    [selectController setDidFinishPickingVideoHandle:^(UIImage *coverImage, PHAsset *assets) {
        NSMutableArray *arr = [NSMutableArray array];
        PHAssetResource *resources = [[PHAssetResource assetResourcesForAsset:assets] firstObject];
        NSURL *pathUrl = (NSURL *)[resources valueForKey:@"privateFileURL"];
        [arr addObject: @{
            @"path": [pathUrl absoluteString],
            @"mediaTypeMsg": videoMsgName
        }];
        NSDictionary *map = @{
            @"fileList": arr,
            @"code": @200
        };
        [methodChannel invokeMethod:callbackName arguments: map];
        
    }];
    
    // 图片选择回调
    [selectController setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        NSMutableArray *arr = [NSMutableArray array];
        if(assets.count > 0) {
            for (PHAsset *item in assets) {
                PHAssetResource *resources = [[PHAssetResource assetResourcesForAsset:item] firstObject];
                NSURL *pathUrl = (NSURL *)[resources valueForKey:@"privateFileURL"];
                [arr addObject: @{
                    @"path": [pathUrl absoluteString],
                    @"mediaTypeMsg": imageMsgName
                }];
            }
        }
        NSDictionary *map = @{
            @"fileList": arr,
            @"code": @200
        };
        [methodChannel invokeMethod:callbackName arguments: map];
    }];
    
    
    // 调用文件选择方法
    [viewController presentViewController:selectController animated:YES completion:^{
    }];
    
}


- (void)selectTypeHandle:(TZImagePickerController *)selectController withMediaType:(NSNumber *)mediaType{
    switch([mediaType intValue]) {
        case 0:
            NSLog(@"全选");
            selectController.allowTakeVideo = YES;
            selectController.allowPickingVideo = YES;
            selectController.allowTakePicture = YES;
            selectController.allowPickingImage = YES;
            return;
        case 1:
            NSLog(@"图片");
            selectController.allowTakeVideo = NO;
            selectController.allowPickingVideo = NO;
            selectController.allowTakePicture = YES;
            selectController.allowPickingImage = YES;
            return;
        case 2:
            NSLog(@"拍摄图片");
            selectController.allowTakeVideo = NO;
            selectController.allowPickingVideo = NO;
            selectController.allowTakePicture = YES;
            selectController.allowPickingImage = NO;
            return;
        case 3:
            NSLog(@"视频");
            selectController.allowTakeVideo = YES;
            selectController.allowPickingVideo = YES;
            selectController.allowTakePicture = NO;
            selectController.allowPickingImage = NO;
            return;
        case 4:
            NSLog(@"拍摄视频");
            selectController.allowTakeVideo = NO;
            selectController.allowPickingVideo = YES;
            selectController.allowTakePicture = NO;
            selectController.allowPickingImage = NO;
            return;
    }
}



- (void)resultHandle{
    
}

@end

