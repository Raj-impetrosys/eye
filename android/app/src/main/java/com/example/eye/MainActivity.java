package com.example.eye;
//
//import android.Manifest;
//import android.content.res.Configuration;
//import android.graphics.Bitmap;
//import android.graphics.BitmapFactory;
//import android.media.MediaScannerConnection;
//import android.net.Uri;
//import android.os.Bundle;
//import android.os.Environment;
//import android.os.Handler;
//import android.util.Log;
//import android.widget.EditText;
//import android.widget.ImageView;
//import android.widget.Toast;
//
//import androidx.annotation.NonNull;
//import androidx.annotation.Nullable;
////import androidx.core.app.ActivityCompat;
//
//import com.mantra.mis100.IrisData;
//import com.mantra.mis100.MIS100;
//import com.mantra.mis100.MIS100Event;
//
//import java.io.File;
//import java.io.FileOutputStream;
//import java.util.Objects;
//
//import io.flutter.embedding.android.FlutterActivity;
//import io.flutter.embedding.engine.FlutterEngine;
//import io.flutter.plugin.common.BinaryMessenger;
//import io.flutter.plugin.common.EventChannel;
//import io.flutter.plugin.common.MethodChannel;
//import io.flutter.plugin.common.MethodChannel.Result;
////import io.flutter.plugins.GeneratedPluginRegistrant;
//
//public class MainActivity extends FlutterActivity implements MIS100Event{
//
//    ImageView imgIris;
//    EditText edtQuality;
//    EditText edtTimeOut;
//
//    private EventChannel messageChannel = null;
//    private EventChannel.EventSink eventSink = null;
//
////    @Override
////    public void onListen(Object arguments, EventChannel.EventSink events) {
////        this.eventSink = events;
////        createListener(events);
////        System.out.print(arguments);
////        System.out.print(events);
////    }
//
//    Bitmap bmp;
//
//    public void createListener(EventChannel.EventSink event) {
//        event.success(bmp);
//    }
//
//    public Bitmap setEvent(Bitmap bmp) {
//        this.bmp = bmp;
//        return bmp;
//    };
////
////    @Override
////    public void onCancel(Object arguments) {
////        eventSink = null;
////        messageChannel = null;
////    }
//
//    private enum ScannerAction {
//        Capture
//    }
//
//    byte[] Enroll_Template;
//    ScannerAction scannerAction = ScannerAction.Capture;
//
//    MIS100 mis100;
//    byte[] _bitmap;
//
//    private static boolean isCaptureRunning = false;
//    public static final String PERMISSION_WRITE_STORAGE = Manifest.permission.WRITE_EXTERNAL_STORAGE;
//    public static final String PERMISSION_READ_STORAGE = Manifest.permission.READ_EXTERNAL_STORAGE;
////    public static final String MANAGE_EXTERNAL_STORAGE = Manifest.permission.MANAGE_EXTERNAL_STORAGE;
//
//    public static String[] Permission = new String[] { PERMISSION_WRITE_STORAGE, PERMISSION_READ_STORAGE };
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
////        GeneratedPluginRegistrant.registerWith(flutterEngine);
////        messageChannel = EventChannel(flutterEngine, "eventChannelStream");
////        messageChannel?.setStreamHandler(this);
//
//    }
//
//
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        requestPermissions(Permission, 1);
//
//        String EVENTCHANNEL = "eventChannelStream";
//        messageChannel =new EventChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(),EVENTCHANNEL);
////        messageChannel.setStreamHandler((EventChannel.StreamHandler handler)->{
////            handler.onListen(Object arguments, EventChannel.EventSink events){
////                createListener(events);
////            };
////        });
//        setMessageChannel(messageChannel);
////        messageChannel.setStreamHandler(this);
//
//
//
//        String CHANNEL = "irisChannel";
//        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
//                (methodCall, result) -> {
//                    switch (methodCall.method) {
//                        case "init":
//                            String info = InitScanner();
//                            result.success(info);
//                            break;
//                        case "getDeviceInfo":
//                             info = "Serial: " + mis100.GetDeviceInfo().SerialNo()
//                                    + " Make: " + mis100.GetDeviceInfo().Make()
//                                    + " Model: " + mis100.GetDeviceInfo().Model()
//                                    + "\nCertificate: " + mis100.GetCertification()
//                                    + "\nSDK Version: " + mis100.GetSDKVersion();
//                            result.success(info);
//                            break;
//                        case "startScan":
//                            if (!isCaptureRunning) {
//                                 StartSyncCapture(result);
////                                    result.success(_bitmap);
//                            }else{
//                                StopCapture(result);
//                            }
//                            break;
//                        case "stopScan":
//                            if (isCaptureRunning) {
//                                StopCapture(result);
//                            }
//                            break;
//                        case "unInit":
//                            UnInitScanner();
//                            break;
//                    }
//
////                        result.success("success");
//                });
//
////
////          try {
////         File file = new File(Environment.getExternalStorageDirectory() + "/MIS100/");
////          if (!file.exists()) {
////          //noinspection ResultOfMethodCallIgnored
////          file.mkdirs();
////          }
////          } catch (Exception ignored) {
////          }
////
////        // FindFormControls();
////        try {
////            this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
////        } catch (Exception e) {
////            Log.e("Error", e.toString());
////        }
//    }
//
//    @Override
//    public void onConfigurationChanged(@NonNull Configuration newConfig) {
//        super.onConfigurationChanged(newConfig);
///*
//         setContentView(R.layout.activity_mis100_sample);
//         FindFormControls();
//*/
//
//        if (isCaptureRunning) {
//            if (mis100 != null) {
//                mis100.StopAutoCapture();
//            }
//        }
//        Handler handler = new Handler();
//        handler.postDelayed(() -> {
//            if (mis100 == null) {
//                mis100 = new MIS100(MainActivity.this);
//                 mis100.SetApplicationContext(MainActivity.this);
//            } else {
//                InitScanner();
//            }
//
//        }, 2000);
//
//    }
//
//    @Override
//    protected void onStart() {
//        if (mis100 == null) {
//            mis100 = new MIS100(this);
//             mis100.SetApplicationContext(MainActivity.this);
//        } else {
//            InitScanner();
//        }
//        super.onStart();
//    }
//
//    protected void onStop() {
//        UnInitScanner();
//        super.onStop();
//    }
//
//    @Override
//    protected void onDestroy() {
//        if (mis100 != null) {
//            mis100.Dispose();
//        }
//        super.onDestroy();
//    }
//
//    // public void FindFormControls() {
//    // btnInit = (Button) findViewById(R.id.btnInit);
//    // btnUninit = (Button) findViewById(R.id.btnUninit);
//    // btnClearLog = (Button) findViewById(R.id.btnClearLog);
//    // lblMessage = (TextView) findViewById(R.id.lblMessage);
//    // txtEventLog = (EditText) findViewById(R.id.txtEventLog);
//    // imgIris = (ImageView) findViewById(R.id.imgIris);
//    // btnSyncCapture = (Button) findViewById(R.id.btnSyncCapture);
//    // btnStopCapture = (Button) findViewById(R.id.btnStopCapture);
//    // edtQuality = (EditText) findViewById(R.id.edtQuality);
//    // edtTimeOut = (EditText) findViewById(R.id.edtTimeOut);
//    // }
//
//    // public void onControlClicked(View v) {
//    //
//    // switch (v.getId()) {
//    // case R.id.btnInit:
//    // InitScanner();
//    // break;
//    // case R.id.btnUninit:
//    // UnInitScanner();
//    // break;
//    // case R.id.btnSyncCapture:
//    // scannerAction = ScannerAction.Capture;
//    // if (!isCaptureRunning) {
//    // StartSyncCapture();
//    // }
//    // break;
//    // case R.id.btnStopCapture:
//    // StopCapture();
//    // break;
//    // case R.id.btnClearLog:
//    // ClearLog();
//    // break;
//    // default:
//    // break;
//    // }
//    // }
//
//    private String InitScanner() {
//        try {
//            int ret = mis100.Init();
//            System.out.print(ret);
//            if (ret != 0) {
////                Toast.makeText(this, ret,
////                        Toast.LENGTH_LONG).show();
//                // SetTextOnUIThread(mis100.GetErrorMsg(ret));
//            } else {
////                showSuccessLog();
//                // SetTextOnUIThread("Init success");
//                //                result.success(info);
//                return "Serial: " + mis100.GetDeviceInfo().SerialNo()
//                        + " Make: " + mis100.GetDeviceInfo().Make()
//                        + " Model: " + mis100.GetDeviceInfo().Model()
//                        + "\nCertificate: " + mis100.GetCertification()
//                        + "\nSDK Version: " + mis100.GetSDKVersion();
//                // SetLogOnUIThread(info);
////                Toast.makeText(this, info,
////                        Toast.LENGTH_LONG).show();
//            }
//        } catch (Exception ex) {
////            Toast.makeText(this, ex.getLocalizedMessage(),
////                    Toast.LENGTH_LONG).show();
//            // SetTextOnUIThread("Init failed, unhandled exception");
//        }
//         return "info";
//    }
//
//    private void StartSyncCapture(Result result) {
//        new Thread(() -> {
////                SetTextOnUIThread("");
//            isCaptureRunning = true;
//            try {
//                IrisData irisData = new IrisData();
//                int quality = 80;
//                try {
//                    quality = Integer.parseInt(edtQuality.getText().toString());
//                } catch (Exception e) {
////                    result.error("400",e.toString(),"quality error");
////                        Toast.makeText(this, e.toString(),Toast.LENGTH_LONG).show();
//                }
//                int timeout = 90000;
//                try {
//                    timeout = Integer.parseInt(edtTimeOut.getText().toString());
//                } catch (Exception e) {
////                    result.error("401",e.toString(),"timeout error");
//                }
//                int ret = mis100.AutoCapture(irisData, quality, timeout);
//
////                mis100.OnMIS100AutoCaptureCallback();
//
//                if (ret != 0) {
////                    result.error("402",mis100.GetErrorMsg(ret),"timeout error");
////                        SetTextOnUIThread(mis100.GetErrorMsg(ret));
//                } else {
////                    final Bitmap bitmap = BitmapFactory.decodeByteArray(irisData.K7Image(), 0,
////                            irisData.K7Image().length);
//                    _bitmap = irisData.IRISImage();
////                    result.success(_bitmap);
//                    runOnUiThread(() -> {
//                        result.success(irisData.IRISImage());
//                    });
////                        DisplayIris(bitmap);
//
//                    String log = "\nCapture Success"
//                            + "\nQuality :: " + irisData.Quality()
//                            + "\nK7ImageLength :: " + irisData.K7Image().length
//                            + "\nK7 Width :: " + irisData.K7ImageWidth()
//                            + "\nK7 Height :: " + irisData.K7ImageHeight();
////                        SetLogOnUIThread(log);
//                    System.out.print(log);
////if(ContextCompat.checkSelfPermission() =='')
////                        if (ContextCompat.checkSelfPermission(
////                                getContext(), Manifest.permission.MANAGE_EXTERNAL_STORAGE) ==
////                                PackageManager.PERMISSION_GRANTED) {
////                            // You can use the API that requires the permission.
////                            SetData2(irisData);
////                        }else {
////                            requestPermissions(Permission, 1);
////                        }
//                    SetData2(irisData);
//                }
//            } catch (Exception ex) {
////                result.error("500",ex.toString(),"Exception");
////                ex.printStackTrace();
////                    SetTextOnUIThread("Error");
//            } finally {
//                isCaptureRunning = false;
//            }
//        }).start();
////        return  _bitmap;
//    }
//
////    private void StartSyncCapture(Result result) {
////        new Thread(new Runnable() {
////
////            @Override
////            public void run() {
////                isCaptureRunning = true;
////                try {
////                    IrisData irisData = new IrisData();
////                    int quality = 40;
////                    try {
////                        quality = Integer.parseInt(edtQuality.getText().toString());
////                    } catch (Exception e) {
////                    }
////                    int timeout = 20000;
////                    try {
////                        timeout = Integer.parseInt(edtTimeOut.getText().toString());
////                    } catch (Exception e) {
////                    }
////                    int ret = mis100.AutoCapture(irisData, quality, timeout);
////                    if (ret != 0) {
////                    } else {
////                        final Bitmap bitmap = BitmapFactory.decodeByteArray(irisData.K7Image(), 0,
////                                irisData.K7Image().length);
////                        System.out.print(bitmap);
//////                        result.success(irisData.IRISImage());
////                        runOnUiThread(() -> {
////                            result.success(irisData.IRISImage());
////                        });
////                        String log = "\nCapture Success"
////                                + "\nQuality :: " + irisData.Quality()
////                                + "\nK7ImageLength :: " + irisData.K7Image().length
////                                + "\nK7 Width :: " + irisData.K7ImageWidth()
////                                + "\nK7 Height :: " + irisData.K7ImageHeight();
//////                        SetData2(irisData);
////                    }
////                } catch (Exception ex) {
////                    ex.printStackTrace();
////                } finally {
////                    isCaptureRunning = false;
////                }
////            }
////        }).start();
////    }
//
//    private void StopCapture(Result result) {
//        try {
//            mis100.StopAutoCapture();
//            isCaptureRunning = false;
//            result.success("capture stopped");
//        } catch (Exception e) {
////            SetTextOnUIThread("Error");
//            result.error("400","can not stopped scanning","try again...");
//        }
//    }
//
//    private void UnInitScanner() {
//        if (mis100 != null)
//             isCaptureRunning=true;
//            try {
//                assert mis100 != null;
//                int ret = mis100.UnInit();
//                if (ret != 0) {
////                    Toast.makeText(this, "error",
////                            Toast.LENGTH_LONG).show();
////                    SetTextOnUIThread(mis100.GetErrorMsg(ret));
//                } else {
////                    Toast.makeText(this, "Uninit Success",
////                            Toast.LENGTH_LONG).show();
////                    SetLogOnUIThread("Uninit Success");
////                    SetTextOnUIThread("Uninit Success");
//                }
//            } catch (Exception e) {
//                Log.e("UnInitScanner.EX", e.toString());
//            }
//    }
//
////    private void DisplayIris(final Bitmap bitmap) {
////        imgIris.post(new Runnable() {
////            @Override
////            public void run() {
////                imgIris.setImageBitmap(bitmap);
////            }
////        });
////    }
//// Storage Permissions
////private static final int REQUEST_EXTERNAL_STORAGE = 1;
////    private static String[] PERMISSIONS_STORAGE = {
//////            if(Build.VERSION.SDK_INT>=Build.VERSION_CODES.R){
//////        Manifest.permission.MANAGE_EXTERNAL_STORAGE,
//////    }
////            Manifest.permission.MANAGE_EXTERNAL_STORAGE,
////            Manifest.permission.READ_EXTERNAL_STORAGE,
////            Manifest.permission.WRITE_EXTERNAL_STORAGE,
////    };
////
////    /**
////     * Checks if the app has permission to write to device storage
////     *
////     * If the app does not has permission then the user will be prompted to grant permissions
////     *
////     * @param activity
////     */
////    public static void verifyStoragePermissions(Activity activity) {
////        // Check if we have write permission
////        int permission = ActivityCompat.checkSelfPermission(activity, Manifest.permission.WRITE_EXTERNAL_STORAGE);
////
////        if (permission != PackageManager.PERMISSION_GRANTED) {
////            // We don't have permission so prompt the user
////            ActivityCompat.requestPermissions(
////                    activity,
////                    PERMISSIONS_STORAGE,
////                    REQUEST_EXTERNAL_STORAGE
////            );
////        }
////    }
//
//    void createExternalStoragePublicPicture() {
//        // Create a path where we will place our picture in the user's
//        // public pictures directory.  Note that you should be careful about
//        // what you place here, since the user often manages these files.  For
//        // pictures and other media owned by the application, consider
//        // Context.getExternalMediaDir().
//        File path = Environment.getExternalStoragePublicDirectory(
//                Environment.DIRECTORY_PICTURES);
//        System.out.print(path);
//        File file = new File(path, "DemoPicture.jpg");
//
//        try {
//            // Make sure the Pictures directory exists.
//            path.mkdirs();
//
//            // Very simple code to copy a picture from the application's
//            // resource into the external file.  Note that this code does
//            // no error checking, and assumes the picture is small (does not
//            // try to copy it in chunks).  Note that if external storage is
//            // not currently mounted this will silently fail.
////            InputStream is = getResources().openRawResource(R.drawable);
////            OutputStream os = new FileOutputStream(file);
////            byte[] data = new byte[is.available()];
////            is.read(data);
////            os.write(data);
////            is.close();
////            os.close();
//
//            // Tell the media scanner about the new file so that it is
//            // immediately available to the user.
//            MediaScannerConnection.scanFile(this,
//                    new String[] { file.toString() }, null,
//                    new MediaScannerConnection.OnScanCompletedListener() {
//                        public void onScanCompleted(String path, Uri uri) {
//                            Log.i("ExternalStorage", "Scanned " + path + ":");
//                            Log.i("ExternalStorage", "-> uri=" + uri);
//                        }
//                    });
//        } catch (Exception e) {
//            // Unable to create file, likely because external storage is
//            // not currently mounted.
//            Log.w("ExternalStorage", "Error writing " + file, e);
//        }
//    }
//
//
//    private void WriteFile(String filename, byte[] bytes) {
////        verifyStoragePermissions(this);
////        createExternalStoragePublicPicture();
//
//        try {
////            String path = Environment.getExternalStorageDirectory()
//            String path = Environment.getExternalStorageDirectory()
////            String path = Environment.getExternalStoragePublicDirectory(
////                    Environment.DIRECTORY_PICTURES)
//                    + "//IrisData";
//            File file = new File(path);
//            if (!file.exists()) {
//                boolean isWriteSuccess = file.mkdirs();
////                Toast.makeText(this, Boolean.toString(isWriteSuccess) ,Toast.LENGTH_LONG).show();
//            }
//            path = path + "//" + filename;
//            file = new File(path);
//            if (!file.exists()) {
//                boolean isCreatedNewFile = file.createNewFile();
////                Toast.makeText(this, Boolean.toString(isCreatedNewFile) ,Toast.LENGTH_LONG).show();
//            }
//            FileOutputStream stream = new FileOutputStream(path);
//            stream.write(bytes);
//            stream.close();
//        } catch (Exception e1) {
//            e1.printStackTrace();
//        }
//    }
//
//    public void SetData2(IrisData irisData) {
//        if (scannerAction.equals(ScannerAction.Capture)) {
//            Enroll_Template = new byte[irisData.ISOTemplate().length];
//            System.arraycopy(irisData.ISOTemplate(), 0, Enroll_Template, 0,
//                    irisData.ISOTemplate().length);
//        }
//
//        WriteFile("Raw.raw", irisData.RawData());
//        WriteFile("K7.bmp", irisData.K7Image());
//        WriteFile("Iris.bmp", irisData.IRISImage());
//        WriteFile("ISOTemplate.iso", irisData.ISOTemplate());
//    }
//
//    @Override
//    public void OnDeviceAttached(final int vid, final int pid, boolean hasPermission) {
//        if (!hasPermission) {
//            Toast.makeText(this, "Permission denied" ,Toast.LENGTH_LONG).show();
////            SetTextOnUIThread("Permission denied");
//            return;
//        }
//        new Thread(() -> {
//            if (vid == 11279 && pid == 8448) {
//                InitScanner();
//            }
//        }).start();
//    }
//
////    private void showSuccessLog() {
////        Toast.makeText(this, "device attached",
////                Toast.LENGTH_LONG).show();
//////        SetTextOnUIThread("Init success");
////        String info = "Serial: "
////                + mis100.GetDeviceInfo().SerialNo() + "\nMake: "
////                + mis100.GetDeviceInfo().Make() + "\nModel: "
////                + mis100.GetDeviceInfo().Model() + "\nWidth: "
////                + mis100.GetDeviceInfo().Width() + "\nHeight: "
////                + mis100.GetDeviceInfo().Height()
////                + "\nCertificate: " + mis100.GetCertification();
//////        SetLogOnUIThread(info);
////    }
//
//    @Override
//    public void OnDeviceDetached() {
//        UnInitScanner();
////        SetTextOnUIThread("Device removed");
//    }
//
//    @Override
//    public void OnHostCheckFailed(String err) {
//        try {
////            SetLogOnUIThread(err);
//            Toast.makeText(this, err, Toast.LENGTH_LONG).show();
//        } catch (Exception ignored) {
//        }
//    }
//
//    public void setMessageChannel(EventChannel messageChannel) {
//        this.messageChannel = messageChannel;
//    }
//
//    public EventChannel getMessageChannel() {
//        return messageChannel;
//    }
//
//    @Override
//    public void OnMIS100AutoCaptureCallback(int ErrorCode, int Quality, byte[] irisImage) {
////        System.out.print(ErrorCode);
//        if (ErrorCode != 0) {
//            return;
//        }
//        EventChannel.StreamHandler streamHandler = new EventChannel.StreamHandler() {
//            @Override
//            public void onListen(Object arguments, EventChannel.EventSink events) {
//                eventSink = events;
//                events.success(irisImage);
//                events.notifyAll();
//            }
//
//            @Override
//            public void onCancel(Object arguments) {
//                Log.e("platform_channel", "arguments: " + arguments.toString());
//                eventSink.endOfStream();
//            }
//        };
//        messageChannel.setStreamHandler(streamHandler);
//
//        //        System.out.print(irisImage.length);
////        System.out.print(Quality);
////        eventSink.success(irisImage);
//    }
//
////    @Override public void OnMIS100AutoCaptureCallback(int ErrorCode, int Quality, byte[] irisImage) {
////        if (ErrorCode != 0) {
////            return;
//////        SetTextonuiThread("Error: " + ErrorCode + "(" + mis100.GetErrorMsg(ErrorCode) + ")");
////    } final Bitmap bitmap = BitmapFactory.decodeByteArray(irisImage, 0, irisImage.length);
////    imgIris.post(new Runnable() {
////        @Override public void run() {
////            imgIris.setImageBitmap(bitmap);
////    imgIris.refreshDrawableState();
////            System.out.print(irisImage);
////        System.out.print(Quality);
////        eventSink.success(irisImage);
////        } });
//////    SetTextonuiThread("Quality: " + Quality);
////    }
//
////    @Override
////    public void OnMIS100AutoCaptureCallback(int ErrorCode, int Quality, byte[] irisImage) {
//////        System.out.print("ttttttttt");
////        if (ErrorCode != 0) {
//////            SetTextOnUIThread("Err :: " + ErrorCode + " (" + mis100.GetErrorMsg(ErrorCode) + ")");
////            return;
////        }
//////        SetTextOnUIThread("Quality :: " + Quality);
////        final Bitmap bmp = BitmapFactory.decodeByteArray(irisImage, 0, irisImage.length);
////        eventSink.success(irisImage);
//////        eventSink.
////        Toast.makeText(this, irisImage.length+ErrorCode+Quality,
////                        Toast.LENGTH_LONG).show();
////        setEvent(bmp);
////        System.out.print(irisImage);
////        imgIris.post(() -> imgIris.setImageBitmap(bmp));
////    }
//}



//// MidIrisAuth SDK

//package com.mantra.midirisauthsample;

import static androidx.core.app.ActivityCompat.requestPermissions;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Matrix;
import android.graphics.Paint;
import android.os.Build;
import android.os.Bundle;
import android.os.SystemClock;
import android.util.Log;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.WindowManager;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.Spinner;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
//import androidx.appcompat.app.AppCompatActivity;
//import androidx.drawerlayout.widget.DrawerLayout;
//import androidx.recyclerview.widget.LinearLayoutManager;
//import androidx.recyclerview.widget.RecyclerView;
//
//import com.google.android.material.navigation.NavigationView;
import com.mantra.midirisauth.DeviceInfo;
import com.mantra.midirisauth.IrisAnatomy;
import com.mantra.midirisauth.MIDIrisAuth;
import com.mantra.midirisauth.MIDIrisAuthNative;
import com.mantra.midirisauth.MIDIrisAuth_Callback;
import com.mantra.midirisauth.enums.DeviceDetection;
import com.mantra.midirisauth.enums.DeviceModel;
import com.mantra.midirisauth.enums.ImageFormat;
//import com.mantra.midirisauthsample.adapter.ActionAdapter;
//import com.mantra.midirisauthsample.adapter.MenuAdapter;
//import com.mantra.midirisauthsample.adapter.NavigationMenuItem;
//import com.mantra.midirisauthsample.adapter.SelectorAdapter;
//import com.mantra.midirisauthsample.dialog.SelectImageFormatDialog;
//import com.mantra.midirisauthsample.dialog.SelectQualityDialog;
//import com.mantra.midirisauthsample.dialog.SelectTemplateFormatDialog;
//import com.mantra.midirisauthsample.dialog.SelectTimeoutDialog;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
//
//import butterknife.BindView;
//import butterknife.ButterKnife;
//import butterknife.OnClick;

import static com.mantra.midirisauth.enums.ImageFormat.BMP;
import static com.mantra.midirisauth.enums.ImageFormat.RAW;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterFragmentActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity implements MIDIrisAuth_Callback, EventChannel.StreamHandler {

//    @BindView(R.id.menuitem_list)
//    RecyclerView menuitemList;
//    @BindView(R.id.nav_view)
//    NavigationView navView;
//    @BindView(R.id.drawer_layout)
//    DrawerLayout drawerLayout;
//    @BindView(R.id.ivStaticMenu)
//    ImageView ivStaticMenu;
//    @BindView(R.id.rlSideMenu)
//    RelativeLayout rlSideMenu;
//    @BindView(R.id.ivSettingMenu)
//    ImageView ivSettingMenu;
//    @BindView(R.id.menu_action_list)
//    RecyclerView menuActionList;
//    @BindView(R.id.spDeviceName)
    Spinner spDeviceName;
//    @BindView(R.id.imgIris)
    ImageView imgIris;
//    @BindView(R.id.txtApp)
//    TextView txtApp;
//    @BindView(R.id.txtCaptureStatus)
//    TextView txtCaptureStatus;
//    @BindView(R.id.txtStatusMessage)
//    TextView txtStatusMessage;
//    @BindView(R.id.txtMake)
//    TextView txtMake;
//    @BindView(R.id.txtModel)
//    TextView txtModel;
//    @BindView(R.id.txtSerialNo)
//    TextView txtSerialNo;
//    @BindView(R.id.txtWH)
//    TextView txtWH;
//    @BindView(R.id.iv_status_fp)
    ImageView ivStatusFp;
//    //    private AppBarConfiguration mAppBarConfiguration;
//    private MenuAdapter menuAdapter;
//    private ActionAdapter actionAdapter;
//    ArrayList<NavigationMenuItem> navigationMenuItemArrayList, navigationMenuActionArrayList;


    private MIDIrisAuth midIrisAuth;
    ArrayList<String> modelName;

//    SelectorAdapter adapter;
    private static final String strSelect = "No Device";
    private byte[] lastCapIrisData;
    private DeviceInfo lastDeviceInfo = new DeviceInfo();
    ImageFormat captureImageDatas;
    private final Paint paint = new Paint();


    private enum ScannerAction {
        Capture, MatchIRIS
    }

    private ScannerAction scannerAction = ScannerAction.Capture;
//    private SelectImageFormatDialog selectImageFormatDialog;
//    private SelectTemplateFormatDialog selectTemplateFormatDialog;
//    private SelectQualityDialog selectQualityDialog;
//    private SelectTimeoutDialog selectTimeoutDialog;
    public static long lastClickTime = 0;
    public static int ClickThreshold = 1000;
    int minQuality = 85;
    int timeOut = 90000;
    int BmpHeaderlength = 1078;
    public static final String PERMISSION_WRITE_STORAGE = Manifest.permission.WRITE_EXTERNAL_STORAGE;
    public static final String PERMISSION_READ_STORAGE = Manifest.permission.READ_EXTERNAL_STORAGE;
    public static String[] Permission = new String[]{PERMISSION_WRITE_STORAGE, PERMISSION_READ_STORAGE};

    private EventChannel messageChannel = null;
    private EventChannel.EventSink eventSink = null;

    @Override
    public void onListen(Object arguments, EventChannel.EventSink events) {
        this.eventSink = events;
    }

    @Override
    public void onCancel(Object arguments) {
        eventSink = null;
        messageChannel = null;
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
//        midIrisAuth.IsDeviceConnected();
//        setContentView(R.layout.activity_main);
//        ButterKnife.bind(this);
//        txtApp.setText(getString(R.string.app_name) + "(" + BuildConfig.VERSION_NAME + ")");
//        DrawerLayout drawer = findViewById(R.id.drawer_layout);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(Permission, 1);
        }

//        RecyclerView.LayoutManager mLayoutManager1 = new LinearLayoutManager(MainActivity.this);
//        menuitemList.setLayoutManager(mLayoutManager1);
//        addMenuItem();
//
//        RecyclerView.LayoutManager mLayoutManager = new LinearLayoutManager(MainActivity.this);
//        menuActionList.setLayoutManager(mLayoutManager);
//        addActionItem();
//
//        paint.setStyle(Paint.Style.STROKE);
//        paint.setStrokeWidth(2);
//        paint.setAntiAlias(true);
//
//        navView.setCheckedItem(R.id.nav_home);
//        navView.setNavigationItemSelectedListener(this);
//
//        this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
//
//        modelName = new ArrayList<>();
//        modelName.add(strSelect);
//        adapter = new SelectorAdapter(this, modelName);
//        spDeviceName.setAdapter(adapter);

        midIrisAuth = new MIDIrisAuth(this, this);
        captureImageDatas = (ImageFormat.BMP);
//        clearText();

        midIrisAuth = new MIDIrisAuth(this, this);

        String EVENTCHANNEL = "eventChannelStream";
        messageChannel =new EventChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(),EVENTCHANNEL);
        messageChannel.setStreamHandler(this);
//
        String CHANNEL = "irisChannel";
        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                (methodCall, result) -> {
                    switch (methodCall.method) {
                        case "init":
                            onActionClick(1,"init",result);
                            result.success("init");
                            break;
                        case "getDeviceInfo":
                             String info =
//                                     "Serial: " + midIrisAuth.GetDeviceInfo().SerialNo()
//                                    + " Make: " + midIrisAuth.GetDeviceInfo().Make()
//                                    + " Model: " + midIrisAuth.GetDeviceInfo().Model()
//                                    + "\nCertificate: " + midIrisAuth.GetCertification()
//                                    +
                                             "\nSDK Version: " + midIrisAuth.GetSDKVersion();
                            result.success(info);
                            break;
                        case "startScan":
                            boolean isCaptureRunning = midIrisAuth.IsCaptureRunning();
                            StartSyncCapture(result);
//                            if (!isCaptureRunning) {
//                                 StartSyncCapture(result);
////                                    result.success(_bitmap);
//                            }else{
//                                StopCapture(result);
//                            }
                            break;
                        case "stopScan":
                            //  isCaptureRunning = midIrisAuth.IsCaptureRunning();
                            // if (isCaptureRunning) {
                                StopCapture(result);
                            // }
                            break;
                        case "unInit":
//                            UnInitScanner();
                            break;
                        case "match":
                            matchData();
                            break;
                    }

//                        result.success("success");
                });
    }


//    @Override
//    public boolean onCreateOptionsMenu(Menu menu) {
//        // Inflate the menu; this adds items to the action bar if it is present.
//        getMenuInflater().inflate(R.menu.main, menu);
//        return true;
//    }

//    @Override
//    public boolean onSupportNavigateUp() {
//        return false;
//    }

    @Override
    protected void onStop() {
        if (midIrisAuth.IsCaptureRunning()) {
//            StopCapture(MethodChannel.Result result);
        }
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        try {
            midIrisAuth.Uninit();
            midIrisAuth.Dispose();
        } catch (Exception e) {
            e.printStackTrace();
        }
        super.onDestroy();
    }

//    public void addMenuItem() {
//        try {
//            navigationMenuItemArrayList = new ArrayList<>();
//            NavigationMenuItem navigationMenuItem;
//            try {
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.menu_get_sdk_version);
//                navigationMenuItemArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.menu_supported_device_list);
//                navigationMenuItemArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.menu_select_image_format);
//                navigationMenuItemArrayList.add(navigationMenuItem);
//
//				/*navigationMenuItem = new NavigationMenuItem();
//				navigationMenuItem.menu_name = getString(R.string.menu_select_template_format);
//				navigationMenuItemArrayList.add(navigationMenuItem);*/
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.menu_set_quality);
//                navigationMenuItemArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.menu_set_timeout);
//                navigationMenuItemArrayList.add(navigationMenuItem);
//
//                menuAdapter = new MenuAdapter(MainActivity.this, navigationMenuItemArrayList, this);
//                menuitemList.setAdapter(menuAdapter);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }


//    public void addActionItem() {
//        try {
//            navigationMenuActionArrayList = new ArrayList<>();
//            NavigationMenuItem navigationMenuItem;
//            try {
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.action_check_device);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.init);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.SyncCapture);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.StopSyncCapture);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.AutoCapture);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.saveImage);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.MatchIris);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                navigationMenuItem = new NavigationMenuItem();
//                navigationMenuItem.menu_name = getString(R.string.uninit);
//                navigationMenuActionArrayList.add(navigationMenuItem);
//
//                actionAdapter = new ActionAdapter(MainActivity.this, navigationMenuActionArrayList, this);
//                menuActionList.setAdapter(actionAdapter);
//            } catch (Exception e) {
//                e.printStackTrace();
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//    }


//    @Override
    public void onItemClick(int position, String item_name) {
//        Toast.makeText(this, "onItemClick:" + position + item_name, Toast.LENGTH_LONG).show();
//        drawerLayout.closeDrawer(Gravity.LEFT);
//        clearText();
        switch (position) {
            case 0://sdk version
                String sdkVersion = midIrisAuth.GetSDKVersion();
                setLogs("SDK Version : " + sdkVersion, false);
                break;
            case 1://supported device List
                List<String> supportedList = new ArrayList<>();
                int ret = midIrisAuth.GetSupportedDevices(supportedList);
                if (ret == 0) {
                    StringBuilder str = new StringBuilder();
                    for (String list : supportedList) {
                        if (str.length() != 0) {
                            str.append(", ");
                        }
                        str.append(list);
                    }
                    setLogs("Supported Devices: " + str.toString(), false);
                } else {
                    setLogs("Supported Devices Error: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                }
                break;
            case 2://select Image Format
//                showImageFormatDialog();
                break;
			/*case 3://select Template Format
				showTemplateFormatDialog();
				break;*/
            case 3://Set Quality
//                showSetQualityDialog();
                break;
            case 4://set Timeout
//                showSetTimeoutDialog();
                break;
        }
    }

//    @Override
    public void onActionClick(int position, String item_name, MethodChannel.Result result) {
//        Toast.makeText(this, "onActionClick:" + position + item_name, Toast.LENGTH_LONG).show();
//        drawerLayout.closeDrawer(Gravity.LEFT);
//        clearText();
//        imgIris.post(new Runnable() {
//            @Override
//            public void run() {
//                imgIris.setImageResource(R.drawable.launch_background);
//            }
//        });
        switch (position) {
            case 0://check device,is device connected
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
//                            String device = spDeviceName.getSelectedItem().toString();
                            boolean ret = midIrisAuth.IsDeviceConnected(DeviceModel.MIS100V2);
                            if (ret) {
                                ivStatusFp.post(new Runnable() {
                                    @Override
                                    public void run() {
//                                        ivStatusFp.setImageResource(R.drawable.connect_1);
                                    }
                                });
                                setLogs("Device Connected", false);
                            } else {
                                ivStatusFp.post(new Runnable() {
                                    @Override
                                    public void run() {
//                                        ivStatusFp.setImageResource(R.drawable.disconnect_1);
                                    }
                                });
                                setLogs("Device Not Connected", true);
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            setLogs("Device not found", true);
                        }
                    }
                }).start();
                break;
            case 1://Init
                new Thread(new Runnable() {
                    @Override
                    public void run() {
                        try {
//                            String device = spDeviceName.getSelectedItem().toString();
                            DeviceInfo info = new DeviceInfo();
                            int ret = midIrisAuth.Init(DeviceModel.MIS100V2, info);
                            if (ret != 0) {
                                setLogs("Init: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                            } else {
//                                DeviceInfo info = midFingerAuth.getDeviceInfo();
                                lastDeviceInfo = info;
                                setLogs("Init Success", false);
                                setDeviceInfo(info);
                            }
                        } catch (Exception e) {
                            setLogs("Device not found", false);
                        }
                    }
                }).start();

                break;
            case 2://start Capture
                if (lastDeviceInfo == null) {
                    setLogs("Please run device init first", true);
                    return;
                }
                scannerAction = ScannerAction.Capture;
                StartCapture();
                break;
            case 3://stop Capture
                StopCapture(result);
                break;
            case 4://Auto Capture
                if (lastDeviceInfo == null) {
                    setLogs("Please run device init first", true);
                    return;
                }
                scannerAction = ScannerAction.Capture;
                StartSyncCapture(result);
                break;
            case 5://Save image
                if (lastDeviceInfo == null) {
                    setLogs("Please run device init first", true);
                    return;
                }
                saveData();
                break;
            case 6://Match IRIS
                if (lastDeviceInfo == null) {
                    setLogs("Please run device init first", true);
                    return;
                }
                scannerAction = ScannerAction.MatchIRIS;
//                scannerAction = ScannerAction.MatchAnsi;
                StartSyncCapture(result);

                break;
            case 7://UnInit
                try {
                    int ret = midIrisAuth.Uninit();
                    if (ret == 0) {
                        setLogs("UnInit Success", false);
                    } else {
                        setLogs("UnInit: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                    }
                    lastDeviceInfo = null;
                    setClearDeviceInfo();
                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    captureThread = null;
                }
                break;
        }
    }

    private void setDeviceInfo(DeviceInfo info) {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
                    if (info == null)
                        return;
//                    txtMake.setText(getString(R.string.make) + " " + info.Make);
//                    txtModel.setText(getString(R.string.model) + " " + info.Model);
//                    txtSerialNo.setText(getString(R.string.serial_no) + " " + info.SerialNo);
//                    txtWH.setText(getString(R.string.w_h) + " " + info.Width + " / " + info.Height);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    private void setClearDeviceInfo() {
        runOnUiThread(new Runnable() {
            @Override
            public void run() {
                try {
//                    txtMake.setText(getString(R.string.make));
//                    txtModel.setText(getString(R.string.model));
//                    txtSerialNo.setText(getString(R.string.serial_no));
//                    txtWH.setText(getString(R.string.w_h));
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });
    }

    private void StartCapture() {
        if (midIrisAuth.IsCaptureRunning()) {
            setLogs("StartCapture Ret: " + MIDIrisAuthNative.CAPTURE_ALREADY_STARTED
                    + " (" + midIrisAuth.GetErrorMessage(MIDIrisAuthNative.CAPTURE_ALREADY_STARTED) + ")", true);
            return;
        }
        if (lastDeviceInfo == null) {
            setLogs("Please run device init first", true);
            return;
        }
        try {

//            imgIris.setImageResource(R.drawable.launch_background);
            new Thread(new Runnable() {
                @Override
                public void run() {
                    int compressionRatio = 1;
                    int ret = midIrisAuth.StartCapture(timeOut, minQuality);

                    setLogs("StartCapture Ret: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", ret == 0 ? false : true);
                }
            }).start();

        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private Thread captureThread = null;

    private void StartSyncCapture(MethodChannel.Result result) {
        if (midIrisAuth.IsCaptureRunning() || (captureThread != null && captureThread.isAlive())) {
            setLogs("Start sync Capture Ret: " + MIDIrisAuthNative.CAPTURE_ALREADY_STARTED
                    + " (" + midIrisAuth.GetErrorMessage(MIDIrisAuthNative.CAPTURE_ALREADY_STARTED) + ")", true);
            return;
        }
        if (lastDeviceInfo == null) {
            setLogs("Please run device init first", true);
            return;
        }
        captureThread = new Thread(new Runnable() {
            @Override
            public void run() {
                try {
                    int compressionRatio = 1;
//                    FingerData fingerData = new FingerData();
//                    imgIris.post(new Runnable() {
//                        @Override
//                        public void run() {
////                            imgIris.setImageResource(R.drawable.launch_background);
//                        }
//                    });
                    int qty[] = new int[1];
                    IrisAnatomy irisAnatomy = new IrisAnatomy();
                    setLogs("Auto Capture Started", false);
                    int ret = midIrisAuth.AutoCapture(timeOut, qty, irisAnatomy);
                    /*imgFinger.post(new Runnable() {
                        @Override
                        public void run() {
                            imgFinger.setImageResource(R.drawable.bg_clor_white);
                        }
                    });*/
                    if (ret != 0) {
//                        imgIris.post(new Runnable() {
//                            @Override
//                            public void run() {
//                                imgIris.setImageResource(R.drawable.launch_background);
//                            }
//                        });
                        setLogs("Start Sync Capture Ret: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                    } else {
                        String log = "Capture Success ";
                        String message = "Quality: " + qty[0] /*+ " NFIQ: " + nfiq[0]*/;
                        setLogs(log, false);
//                        setTxtStatusMessage(message);
                        if (scannerAction == ScannerAction.Capture) {
                            int Size = lastDeviceInfo.Width * lastDeviceInfo.Height + BmpHeaderlength;
                            byte[] bImage = new byte[Size];
                            int[] tSize = new int[Size];
                            ret = midIrisAuth.GetImage(bImage, tSize, 0, BMP);
                            if (ret == 0) {
//                        lastCapFingerData = bImage;
                                lastCapIrisData = new byte[Size];
                                System.arraycopy(bImage, 0, lastCapIrisData, 0,
                                        bImage.length);
                                result.success(lastCapIrisData);
                            } else {
//                        setLogs("Please run start capture or auto capture first");
                                setLogs(midIrisAuth.GetErrorMessage(ret), true);
                            }
                        }
                        matchData();

                    }
//                        Log.e("RawImage", Base64.encodeToString(fingerData.RawData(), Base64.DEFAULT));
//                        Log.e("FingerISOTemplate", Base64.encodeToString(fingerData.ISOTemplate(), Base64.DEFAULT));

                } catch (Exception e) {
                    e.printStackTrace();
                } finally {
                    captureThread = null;
                }
            }
        });
        captureThread.start();
    }

    private void StopCapture(MethodChannel.Result result) {
        try {
            int ret = midIrisAuth.StopCapture();
            setLogs("StopCapture: " + ret + " (" + midIrisAuth.GetErrorMessage(ret) + ")", false);
        } catch (Exception e) {
            setLogs("Error", true);
        }
    }

//    @Override
//    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
//        return false;
//    }
//
//    @OnClick(R.id.rlSideMenu)
//    public void onViewClicked() {
//        drawerLayout.openDrawer(Gravity.LEFT);
//    }

//    private void clearText() {
//        runOnUiThread(new Runnable() {
//            @Override
//            public void run() {
//                txtCaptureStatus.setText("");
//                txtStatusMessage.setText("");
//            }
//        });
//    }

    private void setLogs(final String logs, boolean isError) {
        Log.e("setLogs", logs);
//        txtCaptureStatus.post(new Runnable() {
//            @Override
//            public void run() {
////                txtCaptureStatus.append(logs + "\n");
//                if (isError)
//                    txtCaptureStatus.setTextColor(Color.RED);
//                else
//                    txtCaptureStatus.setTextColor(Color.WHITE);
//
//                txtCaptureStatus.setText(logs);
//            }
//        });
    }

//    private void setTxtStatusMessage(final String logs) {
//        txtStatusMessage.post(new Runnable() {
//            @Override
//            public void run() {
//                txtStatusMessage.setText(logs);
//            }
//        });
//    }

    @Override
    public void OnDeviceDetection(String DeviceName, DeviceDetection detection) {
//        DeviceModel deviceModel = DeviceModel.valueFor(DeviceName);
        if (detection == DeviceDetection.CONNECTED) {
            onActionClick(1,"init",null);
            if (DeviceName != null) {
//                ivStatusFp.post(new Runnable() {
//                    @Override
//                    public void run() {
////                        ivStatusFp.setImageResource(R.drawable.connect_1);
//                    }
//                });
//                boolean exist = false;
//                for (String string : modelName) {
//                    if (string.equals(DeviceName)) {
//                        exist = true;
//                        break;
//                    }
//                }
//                if (!exist) {
//                    modelName.add(DeviceName);
//                    modelName.remove(strSelect);
//                }
//                adapter.notifyDataSetChanged();
            }
            setLogs("Device connected", false);
        } else if (detection == DeviceDetection.DISCONNECTED) {
            try {
                lastDeviceInfo = null;
                setLogs("Device Not Connected", true);
//                ivStatusFp.post(new Runnable() {
//                    @Override
//                    public void run() {
////                        ivStatusFp.setImageResource(R.drawable.disconnect_1);
//                    }
//                });
                try {
                    midIrisAuth.Uninit();
                    for (String temp : modelName) {
                        if (temp.equals(DeviceName)) {
                            modelName.remove(temp);
                            if (modelName.size() == 0) {
                                modelName.add(strSelect);
                            }
                            break;
                        }
                    }
//                    adapter.notifyDataSetChanged();
                    setClearDeviceInfo();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    private Bitmap previewBitmap;

    @Override
    public void OnPreview(int ErrorCode, int Quality, byte[] Image, IrisAnatomy irisAnatomy) {
        try {
            if (ErrorCode == 0 && Image != null) {

                int lowerValue = 0;
                if( minQuality > 40 ) {
                    lowerValue = minQuality - 30;
                }
                else {
                    lowerValue = 10;
                }

                if (Quality < lowerValue) {
                    paint.setColor(Color.RED);
                } else if (Quality >= lowerValue && Quality <= minQuality) {
                    paint.setColor(Color.BLUE);
                } else {
                    paint.setColor(Color.GREEN);
                }

                Bitmap bitmap = BitmapFactory.decodeByteArray(Image, 0, Image.length);
                Bitmap bmOverlay = Bitmap.createBitmap(640, 480, Bitmap.Config.ARGB_4444);

                Canvas canvas = new Canvas(bmOverlay);
                canvas.drawBitmap(bitmap, new Matrix(), null);

                int x = irisAnatomy.irisX;
                int y = irisAnatomy.irisY;
                int r = irisAnatomy.irisR;

                int fy = 0;
                int fx = 0;
//            if (y > 1) fy = 480 - y;
                fy = y;
//                if (x > 1) {
//                    fx = 640 - x;
//                }
                fx = x;
                canvas.drawCircle(fx, fy, r, paint);

                ByteArrayOutputStream stream = new ByteArrayOutputStream();
                bmOverlay.compress(Bitmap.CompressFormat.PNG, 100, stream);
                byte[] byteArray = stream.toByteArray();

                try {
                    stream.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
                bitmap.recycle();
                bmOverlay.recycle();
//                ShowImage(byteArray);
                runOnUiThread(()->
                        eventSink.success(Image)
                        );

                setLogs("Preview Quality: " + Quality, false);
            } else {
                setLogs("Preview Error Code: " + ErrorCode + " (" + midIrisAuth.GetErrorMessage(ErrorCode) + ")", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void OnComplete(int ErrorCode, int Quality, byte[] Image, IrisAnatomy anatomy) {
        try {
            if (ErrorCode == 0) {
                String log = "Capture Success";
                String quality = "Quality: " + Quality /*+ " NFIQ: " + NFIQ*/;
                setLogs(log, false);
//                setTxtStatusMessage(quality);
                if (scannerAction == ScannerAction.Capture) {
                    int Size = lastDeviceInfo.Width * lastDeviceInfo.Height + BmpHeaderlength;
                    byte[] bImage = new byte[Size];
                    int[] tSize = new int[Size];
                    int ret = midIrisAuth.GetImage(bImage, tSize, 0, BMP);
                    // midFingerAuth.GetTemplate(bImage, tSize, captureTemplateDatas);
                    if (ret == 0) {
//                        lastCapFingerData = bImage;
                        lastCapIrisData = new byte[Size];
                        System.arraycopy(bImage, 0, lastCapIrisData, 0,
                                bImage.length);
//                scannerAction = ScannerAction.MatchAnsi;
                    } else {
//                        setLogs("Please run start capture or auto capture first");
                        setLogs(midIrisAuth.GetErrorMessage(ret), true);
                    }
                }
            } else {
//                imgIris.post(new Runnable() {
//                    @Override
//                    public void run() {
//                        imgIris.setImageResource(R.drawable.bg_clor_white);
//                    }
//                });
                setLogs("CaptureComplete: " + ErrorCode + " (" + midIrisAuth.GetErrorMessage(ErrorCode) + ")", true);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    private void ShowImage(final byte[] image) {
        imgIris.post(new Runnable() {
            @Override
            public void run() {
                if (image != null) {
                    if (previewBitmap != null) {
                        previewBitmap.recycle();
                        previewBitmap = null;
                    }
                    previewBitmap = BitmapFactory.decodeByteArray(image, 0, image.length);
                    imgIris.setImageBitmap(previewBitmap);
                } else {
                    imgIris.setImageResource(R.drawable.launch_background);
                }
            }
        });
    }

    public void saveData() {
        try {
            int Size = lastDeviceInfo.Width * lastDeviceInfo.Height + BmpHeaderlength;
            int[] iSize = new int[Size];
            byte[] bImage1 = new byte[Size];
            int ret = midIrisAuth.GetImage(bImage1, iSize, 0, captureImageDatas);
            byte[] bImage = new byte[iSize[0]];
            System.arraycopy(bImage1, 0, bImage, 0, iSize[0]);
            if( bImage != null ) {
                Log.e( "AuthSample", "Image not null"+ bImage.length );
            }
            if (ret == 0) {
                switch (captureImageDatas) {
                    case RAW:
                        WriteImageFile("Raw.raw", bImage);
                        break;
                    case BMP:
                        WriteImageFile("Bitmap.bmp", bImage);
                        break;
                    case IIR_K3:
                        WriteImageFile("K3.k3", bImage);
                        break;
                    case IIR_K7:
                        WriteImageFile("K7.k7", bImage);
                        break;
					/*case JPEG2000:
						WriteImageFile("JPEG2000.jp2", bImage);
						break;
					case WSQ:
						WriteImageFile("WSQ.wsq", bImage);
						break;
					case FIR_V2005:
						WriteImageFile("FIR_2005.iso", bImage);
						break;
					case FIR_WSQ_V2005:
						WriteImageFile("FIR_WSQ_2005.iso", bImage);
						break;
					case FIR_V2011:
						WriteImageFile("FIR_2011.iso", bImage);
						break;
					case FIR_WSQ_V2011:
						WriteImageFile("FIR_WSQ_2011.iso", bImage);
						break;
					case FIR_JPEG2000_V2005:
						WriteImageFile("FIR_JPEG2000_2005.iso", bImage);
						break;
					case FIR_JPEG2000_V2011:
						WriteImageFile("FIR_JPEG2000_2011.iso", bImage);
						break;*/
                }

                try {

					/*byte[] bTemplate = new byte[Size];
					ret = midFingerAuth.GetTemplate(bTemplate, iSize, captureTemplateDatas);
					if (ret == 0) {
						switch (captureTemplateDatas) {
							case FMR_V2005:
								WriteTemplateFile("ISOTemplate_2005.iso", bTemplate);
								break;
							case FMR_V2011:
								WriteTemplateFile("ISOTemplate_20011.iso", bTemplate);
								break;
							case ANSI_V378:
								WriteTemplateFile("ANSITemplate_378.iso", bTemplate);
								break;
						}
					} else {
						setLogs("Save Template Ret: " + ret
								+ " (" + midFingerAuth.GetErrorMessage(ret) + ")", true);
					}*/
                } catch (Exception e) {
                    setLogs("Error Saving Template.", true);
                    e.printStackTrace();
                }
            } else {
                setLogs("Save Template Ret: " + ret
                        + " (" + midIrisAuth.GetErrorMessage(ret) + ")", true);
            }


        } catch (Exception e) {
            e.printStackTrace();
            setLogs("Error Saving Image.", true);
        }

    }

    /*  private void WriteImageFile(String filename, byte[] bytes) {
          try {
              String path = Environment.getExternalStorageDirectory()
                      + "//FingerData//Image";
              File file = new File(path);

              if (!file.exists()) {
                  file.mkdirs();
              }
              path = path + "//" + filename;
              file = new File(path);
              if (!file.exists()) {
                  file.createNewFile();
              }
              FileOutputStream stream = new FileOutputStream(path);
              stream.write(bytes);
              stream.close();
              setLogs("Image Saved", false);
          } catch (Exception e1) {
              e1.printStackTrace();
              setLogs("Error Saving Image", false);
          }
      }*/
    private void WriteImageFile(String filename, byte[] bytes) {
        try {
//            File filesDir = getExternalFilesDir(Environment.DIRECTORY_DOCUMENTS);
            /*String path = Environment.getExternalStorageDirectory()
                    + "//FingerData//Template";*/
            String path = getExternalFilesDir(null).toString() + "//IrisData//Image";
            File file = new File(path);
            if (!file.exists()) {
                file.mkdirs();
            }
            path = path + "//" + filename;
            file = new File(path);
            if (!file.exists()) {
                boolean isCreated = file.createNewFile();
            }
            FileOutputStream stream = new FileOutputStream(path);
            stream.write(bytes);
            stream.close();
            setLogs("Image Saved", false);
        } catch (Exception e1) {
            e1.printStackTrace();
            setLogs("Error Saving Image", false);
        }
    }


//    private void showImageFormatDialog() {
//        selectImageFormatDialog = new SelectImageFormatDialog(this);
//        selectImageFormatDialog.show();
//
//
//        selectImageFormatDialog.holder.txtCancel.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                selectImageFormatDialog.dismiss();
//            }
//        });
//
//        selectImageFormatDialog.holder.txtSave.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                captureImageDatas = ImageFormat.BMP;
//                if (selectImageFormatDialog.holder.cbBmp.isChecked()) {
//                    captureImageDatas = (ImageFormat.BMP);
//                } else if (selectImageFormatDialog.holder.cbIIRK3.isChecked()) {
//                    captureImageDatas = (ImageFormat.IIR_K3);
//                } else if (selectImageFormatDialog.holder.cbIIRK7.isChecked()) {
//                    captureImageDatas = (ImageFormat.IIR_K7);
//                } else if (selectImageFormatDialog.holder.cbRaw.isChecked()) {
//                    captureImageDatas = (RAW);
//                }
//				/*else if (selectImageFormatDialog.holder.cbFIRV2005.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_V2005);
//				} else if (selectImageFormatDialog.holder.cbFIRV2011.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_V2011);
//				} else if (selectImageFormatDialog.holder.cbFIRWSQV2005.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_WSQ_V2005);
//				} else if (selectImageFormatDialog.holder.cbFIRWSQV2011.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_WSQ_V2011);
//				} else if (selectImageFormatDialog.holder.cbFIRJPEGV2005.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_JPEG2000_V2005);
//				} else if (selectImageFormatDialog.holder.cbFIRJPEGV2011.isChecked()) {
//					captureImageDatas = (ImageFormat.FIR_JPEG2000_V2011);
//				}*/
//                selectImageFormatDialog.dismiss();
//            }
//        });
//    }

//    private void showTemplateFormatDialog() {
//        selectTemplateFormatDialog = new SelectTemplateFormatDialog(this);
//        selectTemplateFormatDialog.show();
//
//
//        selectTemplateFormatDialog.holder.txtCancel.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                selectTemplateFormatDialog.dismiss();
//            }
//        });
//
//        selectTemplateFormatDialog.holder.txtSave.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//				/*captureTemplateDatas = TemplateFormat.FMR_V2005;
//				if (selectTemplateFormatDialog.holder.cbFMRV2005.isChecked()) {
//					captureTemplateDatas = (TemplateFormat.FMR_V2005);
//				} else if (selectTemplateFormatDialog.holder.cbFMRV2011.isChecked()) {
//					captureTemplateDatas = (TemplateFormat.FMR_V2011);
//				} else if (selectTemplateFormatDialog.holder.cbANSIV378.isChecked()) {
//					captureTemplateDatas = (TemplateFormat.ANSI_V378);
//				}*/
//                selectTemplateFormatDialog.dismiss();
//            }
//        });
//    }

//    private void showSetQualityDialog() {
//        selectQualityDialog = new SelectQualityDialog(this);
//        selectQualityDialog.show();
//        selectQualityDialog.holder.edtMinQuality.setText( "" + minQuality);
//        selectQualityDialog.holder.edtMinQuality.setSelection(selectQualityDialog.holder.edtMinQuality.getText().length());
//        selectQualityDialog.holder.txtCancel.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                selectQualityDialog.dismiss();
//            }
//        });
//
//        selectQualityDialog.holder.txtSave.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                try {
//
//                    minQuality = Integer.parseInt(selectQualityDialog.holder.edtMinQuality.getText().toString());
//                    if( minQuality > 100 ) {
//                        selectQualityDialog.holder.edtMinQuality.setError("Upper bound should be between 1-100");
//                        return;
//                    }
//
//                } catch (NumberFormatException e) {
//                }
//                selectQualityDialog.dismiss();
//            }
//        });
//    }

//    private void showSetTimeoutDialog() {
//        selectTimeoutDialog = new SelectTimeoutDialog(this);
//        selectTimeoutDialog.show();
//
//        selectTimeoutDialog.holder.edtTimeout.setText("" + timeOut);
//        selectTimeoutDialog.holder.edtTimeout.setSelection(selectTimeoutDialog.holder.edtTimeout.getText().length());
//        selectTimeoutDialog.holder.txtCancel.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                selectTimeoutDialog.dismiss();
//            }
//        });
//
//        selectTimeoutDialog.holder.txtSave.setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View v) {
//                // preventing double, using threshold of 1000 ms
//                if (SystemClock.elapsedRealtime() - lastClickTime < ClickThreshold) {
//                    return;
//                }
//                lastClickTime = SystemClock.elapsedRealtime();
//                try {
//                    timeOut = Integer.parseInt(selectTimeoutDialog.holder.edtTimeout.getText().toString());
//                } catch (NumberFormatException e) {
//                }
//                selectTimeoutDialog.dismiss();
//            }
//        });
//    }

    public void matchData() {
		/*new Thread(new Runnable() {
			@Override
			public void run() {*/
        try {
            if (scannerAction.equals(ScannerAction.MatchIRIS) ) {
                if (lastCapIrisData == null) {
                    return;
                }
                int Size = lastDeviceInfo.Width * lastDeviceInfo.Height + BmpHeaderlength;
                byte[] bImage = new byte[Size];
                int[] tSize = new int[Size];
                int ret = midIrisAuth.GetImage(bImage, tSize, 0, BMP);

                if (ret == 0) {
                    byte[] Verify_Image = new byte[Size];
                    System.arraycopy(bImage, 0, Verify_Image, 0, bImage.length);
                    int[] matchScore = new int[1];
                    ret = midIrisAuth.MatchImage(lastCapIrisData, Verify_Image, matchScore);

                    if (ret < 0) {
                        setLogs("Error: " + ret + "(" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                    } else {
                        if (matchScore[0] >= 900) {
                            setLogs("Iris matched with score: " + matchScore[0], false);
                        } else {
                            setLogs("Iris not matched, score: " + matchScore[0], false);
                        }
                    }
                } else {
                    setLogs("Error: " + ret + "(" + midIrisAuth.GetErrorMessage(ret) + ")", true);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
			/*}
		}).start();*/

    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (resultCode == RESULT_OK) {
            if (!hasPermission()) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
                    requestPermissions(Permission, 1);
                }
            } else {
                //permission granted
            }
        }
    }

    private boolean hasPermission() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            return checkSelfPermission(PERMISSION_READ_STORAGE) == PackageManager.PERMISSION_GRANTED &&
                    checkSelfPermission(PERMISSION_WRITE_STORAGE) == PackageManager.PERMISSION_GRANTED;
        } else {
            return true;
        }
    }
}

//class MainActivity extends FlutterFragmentActivity implements MIDIrisAuth_Callback{
//    MIDIrisAuth midIrisAuth;
//    int timeOut = 90000;
//   boolean isCaptureRunning = false;
//
//    @Override
//    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
//        super.configureFlutterEngine(flutterEngine);
//    }
//
//    @Override
//    protected void onCreate(@Nullable Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        midIrisAuth = new MIDIrisAuth(this, this);
//
//        String CHANNEL = "irisChannel";
//        new MethodChannel(Objects.requireNonNull(getFlutterEngine()).getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
//                (methodCall, result) -> {
//                    switch (methodCall.method) {
//                        case "init":
//                            String info = InitScanner();
//                            result.success(info);
//                            break;
//                        case "getDeviceInfo":
//                             info =
////                                     "Serial: " + midIrisAuth.GetDeviceInfo().SerialNo()
////                                    + " Make: " + midIrisAuth.GetDeviceInfo().Make()
////                                    + " Model: " + midIrisAuth.GetDeviceInfo().Model()
////                                    + "\nCertificate: " + midIrisAuth.GetCertification()
////                                    +
//                                             "\nSDK Version: " + midIrisAuth.GetSDKVersion();
//                            result.success(info);
//                            break;
//                        case "startScan":
//                            if (!isCaptureRunning) {
//                                 StartSyncCapture(result);
////                                    result.success(_bitmap);
//                            }else{
//                                StopCapture(result);
//                            }
//                            break;
//                        case "stopScan":
//                            if (isCaptureRunning) {
//                                StopCapture(result);
//                            }
//                            break;
//                        case "unInit":
//                            UnInitScanner();
//                            break;
//                    }
//
////                        result.success("success");
//                });
//    }
//
//    public String InitScanner(){
////        midIrisAuth.Init();
//        return "init";
//    }
//
//    public void UnInitScanner(){
//
//    }
//
//    public void StartSyncCapture(MethodChannel.Result result){
//        int qty[] = new int[1];
//                    IrisAnatomy irisAnatomy = new IrisAnatomy();
////                    setLogs("Auto Capture Started", false);
//                    int ret = midIrisAuth.AutoCapture(timeOut, qty, irisAnatomy);
//                    result.success(ret);
//    }
//
//    public void StopCapture(MethodChannel.Result result){
//        int ret = midIrisAuth.StopCapture();
//        result.success(ret);
//    }
//
//    @Override
//    protected void onDestroy() {
//        super.onDestroy();
//    }
//
//    @Override
//    public void OnDeviceDetection(String s, DeviceDetection deviceDetection) {
//
//    }
//
//    @Override
//    public void OnPreview(int i, int i1, byte[] bytes, IrisAnatomy irisAnatomy) {
//
//    }
//
//    @Override
//    public void OnComplete(int i, int i1, byte[] bytes, IrisAnatomy irisAnatomy) {
//
//    }
//}