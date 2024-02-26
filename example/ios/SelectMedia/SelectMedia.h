//
//  SelectMedia.h
//  Runner
//
//  Created by hello on 2024/2/7.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>
#import <Flutter/Flutter.h>
#import "ViewControllerUtils.h"

NS_ASSUME_NONNULL_BEGIN


/// 选择文件实现类
@interface SelectMedia : NSObject<TZImagePickerControllerDelegate>

@property NSString *callbackName;


-(void)selectMedia: (FlutterMethodChannel*)methodChannel
    withMediaType: (NSNumber*)mediaType
    withLength:(NSNumber*)maxLength
    withSecond:(NSNumber*)maxSecond;

/**
    处理选择的文件类型
 */
-(void)selectTypeHandle: (TZImagePickerController *)selectController
    withMediaType:(NSNumber *)mediaType;

/**
    处理文件选择结果通知 Flutter 端
*/
-(void)resultHandle;

@end

NS_ASSUME_NONNULL_END
