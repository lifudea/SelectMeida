package com.example.select_media;

import java.util.HashMap;
import java.util.Map;

/**
 * 用来返回一个默认map
 */
public class CallbackMap {

    /// 成功 code
    public static int CODE_SUCCESS = 2001;
    /// 失败默认 code
    public static int CODE_FAILED = 300;


    /**
     * 成功回调 map
     */
    public static Map success() {
        Map map = new HashMap();
        map.put("code", CODE_SUCCESS);
        return map;
    }

    /**
     * 失败回调 map
     */
    public static Map failed() {
        Map map = new HashMap();
        map.put("code", CODE_FAILED);
        return map;
    }
}
