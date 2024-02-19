//
//  SelectMedia.h
//  Runner
//
//  Created by hello on 2024/2/7.
//

#import <Foundation/Foundation.h>
#import <TZImagePickerController.h>

NS_ASSUME_NONNULL_BEGIN


/// 选择文件实现类
@interface SelectMedia : NSObject<TZImagePickerControllerDelegate>

-(void)selectMedia:(NSNumber*)mediaType
    withLength:(NSNumber*)maxLength
    withSecond:(NSNumber*)maxSecond;



@end

NS_ASSUME_NONNULL_END
