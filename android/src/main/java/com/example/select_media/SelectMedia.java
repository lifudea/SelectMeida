package com.example.select_media;

import android.app.Activity;
import android.util.Log;

import com.luck.picture.lib.basic.PictureSelector;
import com.luck.picture.lib.entity.LocalMedia;
import com.luck.picture.lib.interfaces.OnResultCallbackListener;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class SelectMedia {


    /**
     * 选择文件
     * @param activity
     *
     */
    SelectMedia(
        Activity activity,
        int selectMediaType,
        int maxLength,
        int maxSecond
    ) {
        if(selectMediaType >= 4) {
            onlyCamera(
                activity,
                selectMediaType,
                maxLength,
                maxSecond
            );
            return;
        }
        select(
            activity,
            selectMediaType,
            maxLength,
            maxSecond
        );
    }

    /**
     * 仅拍摄照相、视频和录制音频、不从文件夹进行选择
     */
    private void onlyCamera(
        Activity activity,
        int selectMediaType,
        int maxLength,
        int maxSecond
    ) {
        PictureSelector.create(activity)
            .openCamera(selectMediaType - 3)
            .forResultActivity(new OnResultCallbackListener<LocalMedia>() {
                @Override
                public void onResult(ArrayList<LocalMedia> result) {
                    resultHandle(result);
                }

                @Override
                public void onCancel() {

                }
            });
    }

    /**
     * 从文件夹选择和拍摄
     */
    private void select(
        Activity activity,
        int selectMediaType,
        int maxLength,
        int maxSecond
    ) {
        //图片选择全部功能
        PictureSelector.create(activity)
            .openGallery(selectMediaType)
            .setImageEngine(SelectEngine.createGlideEngine())
            .setFilterVideoMaxSecond(maxSecond)
            .setMaxSelectNum(maxLength)
            .forResult(new OnResultCallbackListener<LocalMedia>() {
               @Override
               public void onResult(ArrayList<LocalMedia> arrayList) {
                   resultHandle(arrayList);
               }

               @Override
               public void onCancel() {

               }
           }
        );
    }

    /**
     * 处理文件文件选择结果
     */
    private void resultHandle(
        ArrayList<LocalMedia> arrayList
    ) {
        Map<String, Object> result = new HashMap<>();
        ArrayList<Map<String, String>> arr = new ArrayList<>();
        for (LocalMedia localMedia : arrayList) {
            Map<String, String> map = new HashMap<>();
            map.put("path", localMedia.getPath());
            Log.e(""," 选择的文件里贝哦" + localMedia.getVideoThumbnailPath());
            Log.e("", "文件类型" + localMedia.getMimeType());
            if(localMedia.getVideoThumbnailPath() != null) {
                map.put("thumb", localMedia.getVideoThumbnailPath());
            }
            map.put("mediaTypeMsg", localMedia.getMimeType());
            arr.add(map);
        }
        result.put("fileList", arr);
        result.put("code", 200);
        SelectMediaPlugin.channel.invokeMethod(
            SelectMediaPlugin.callbackName,
            result
        );
    }
}

