package com.example.eye;
import com.mantra.mis100.*;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

//public class MainActivity extends FlutterActivity {
//}

import android.Manifest;
import android.app.Activity;
import android.content.res.Configuration;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Build;
import android.os.Environment;
import android.os.Handler;
//        import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.WindowManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.mantra.mis100.IrisData;
        import com.mantra.mis100.MIS100;
        import com.mantra.mis100.MIS100Event;

        import java.io.File;
        import java.io.FileOutputStream;
import androidx.annotation.NonNull;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity implements MIS100Event {


    Button btnInit;
    Button btnUninit;
    Button btnSyncCapture;
    Button btnStopCapture;
    Button btnClearLog;
    TextView lblMessage;
    EditText txtEventLog;
    ImageView imgIris;
    EditText edtQuality;
    EditText edtTimeOut;

    private enum ScannerAction {
        Capture
    }

    byte[] Enroll_Template;
    ScannerAction scannerAction = ScannerAction.Capture;

    MIS100 mis100;

    private static boolean isCaptureRunning = false;
    public static final String PERMISSION_WRITE_STORAGE = Manifest.permission.WRITE_EXTERNAL_STORAGE;
    public static final String PERMISSION_READ_STORAGE = Manifest.permission.READ_EXTERNAL_STORAGE;
    public static String[] Permission = new String[]{PERMISSION_WRITE_STORAGE, PERMISSION_READ_STORAGE};

    private static String CHANNEL = "irisChannel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        GeneratedPluginRegistrant.registerWith(flutterEngine);

    }

    //    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
//        super.configureFlutterEngine(flutterEngine)
//        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
//            call, result ->
//            // Note: this method is invoked on the main thread.
//            // TODO
//        }
//    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            requestPermissions(Permission, 1);
//            InitScanner();
//            if (mis100 == null) {
////                mis100 = new MIS100(MainActivity.this);
//                 mis100 = new MIS100(this);
////                mis100.SetApplicationContext(MainActivity.this);
//            } else {
//                InitScanner();
//            }
        }

        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler(
                new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall methodCall, Result result) {
                        if(methodCall.method=="init"){
                            InitScanner();
                            result.success("init success");
                        }else if(methodCall.method=="getdata"){
                            result.success("get data success");
                        }else if(methodCall.method=="start_scan"){
                            StartSyncCapture();
                            result.success("started");
                        }else if(methodCall.method=="uninit"){
UnInitScanner();
                        }

                        result.success("success");
                    }
                }
        );
//        new MethodChannel(getFlutterEngine().getDartExecutor().getBinaryMessenger(), CHANNEL).setMethodCallHandler
//              {call,result-> if (call.method.equals("iris")) {
//            String greetings = helloFromNativeCode();
//            result.success(greetings);
//        }
//    }
//        setContentView(R.layout.activity_mis100_sample);
//        InitScanner();

        /*try {
            File file = new File(Environment.getExternalStorageDirectory() + "/MIS100/");
            if (!file.exists()) {
                //noinspection ResultOfMethodCallIgnored
                file.mkdirs();
            }
        } catch (Exception ignored) {
        }*/
//        FindFormControls();
        try {
            this.getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);
        } catch (Exception e) {
            Log.e("Error", e.toString());
        }
    }

    @Override
    public void onConfigurationChanged(Configuration newConfig) {
        super.onConfigurationChanged(newConfig);
//        setContentView(R.layout.activity_mis100_sample);
//        FindFormControls();

        if (isCaptureRunning) {
            if (mis100 != null) {
                mis100.StopAutoCapture();
            }
        }
        Handler handler = new Handler();
        handler.postDelayed(new Runnable() {
            @Override
            public void run() {
                if (mis100 == null) {
                    mis100 = new MIS100(MainActivity.this);
//                    mis100.SetApplicationContext(MainActivity.this);
                } else {
                    InitScanner();
                }

            }
        }, 2000);


    }

    @Override
    protected void onStart() {
        if (mis100 == null) {
            mis100 = new MIS100(this);
//            mis100.SetApplicationContext(MainActivity.this);
        } else {
            InitScanner();
        }
        super.onStart();
    }

    protected void onStop() {
        UnInitScanner();
        super.onStop();
    }

    @Override
    protected void onDestroy() {
        if (mis100 != null) {
            mis100.Dispose();
        }
        super.onDestroy();
    }

//    public void FindFormControls() {
//        btnInit = (Button) findViewById(R.id.btnInit);
//        btnUninit = (Button) findViewById(R.id.btnUninit);
//        btnClearLog = (Button) findViewById(R.id.btnClearLog);
//        lblMessage = (TextView) findViewById(R.id.lblMessage);
//        txtEventLog = (EditText) findViewById(R.id.txtEventLog);
//        imgIris = (ImageView) findViewById(R.id.imgIris);
//        btnSyncCapture = (Button) findViewById(R.id.btnSyncCapture);
//        btnStopCapture = (Button) findViewById(R.id.btnStopCapture);
//        edtQuality = (EditText) findViewById(R.id.edtQuality);
//        edtTimeOut = (EditText) findViewById(R.id.edtTimeOut);
//    }

//    public void onControlClicked(View v) {
//
//        switch (v.getId()) {
//            case R.id.btnInit:
//                InitScanner();
//                break;
//            case R.id.btnUninit:
//                UnInitScanner();
//                break;
//            case R.id.btnSyncCapture:
//                scannerAction = ScannerAction.Capture;
//                if (!isCaptureRunning) {
//                    StartSyncCapture();
//                }
//                break;
//            case R.id.btnStopCapture:
//                StopCapture();
//                break;
//            case R.id.btnClearLog:
//                ClearLog();
//                break;
//            default:
//                break;
//        }
//    }

    private void InitScanner() {
        try {
            int ret = mis100.Init();
            if (ret != 0) {
                Toast.makeText(this, "success",
                        Toast.LENGTH_LONG).show();
//                SetTextOnUIThread(mis100.GetErrorMsg(ret));
            } else {
//                SetTextOnUIThread("Init success");
                String info = "Serial: " + mis100.GetDeviceInfo().SerialNo()
                        + " Make: " + mis100.GetDeviceInfo().Make()
                        + " Model: " + mis100.GetDeviceInfo().Model()
                        + "\nCertificate: " + mis100.GetCertification()
                        + "\nSDK Version: " + mis100.GetSDKVersion();
//                SetLogOnUIThread(info);
                Toast.makeText(this, info,
                        Toast.LENGTH_LONG).show();
            }
        } catch (Exception ex) {
            Toast.makeText(this, ex.toString(),
                    Toast.LENGTH_LONG).show();
//            SetTextOnUIThread("Init failed, unhandled exception");
        }
//        return info
    }

    private void StartSyncCapture() {
        new Thread(new Runnable() {

            @Override
            public void run() {
                SetTextOnUIThread("");
                isCaptureRunning = true;
                try {
                    IrisData irisData = new IrisData();
                    int quality = 40;
                    try {
                        quality = Integer.parseInt(edtQuality.getText().toString());
                    } catch (Exception e) {
                    }
                    int timeout = 20000;
                    try {
                        timeout = Integer.parseInt(edtTimeOut.getText().toString());
                    } catch (Exception e) {
                    }
                    int ret = mis100.AutoCapture(irisData, quality, timeout);
                    if (ret != 0) {
                        SetTextOnUIThread(mis100.GetErrorMsg(ret));
                    } else {
                        final Bitmap bitmap = BitmapFactory.decodeByteArray(irisData.K7Image(), 0,
                                irisData.K7Image().length);
                        DisplayIris(bitmap);

                        String log = "\nCapture Success"
                                + "\nQuality :: " + irisData.Quality()
                                + "\nK7ImageLength :: " + irisData.K7Image().length
                                + "\nK7 Width :: " + irisData.K7ImageWidth()
                                + "\nK7 Height :: " + irisData.K7ImageHeight();
                        SetLogOnUIThread(log);
                        SetData2(irisData);
                    }
                } catch (Exception ex) {
                    ex.printStackTrace();
                    SetTextOnUIThread("Error");
                } finally {
                    isCaptureRunning = false;
                }
            }
        }).start();
    }

    private void StopCapture() {
        try {
            mis100.StopAutoCapture();
        } catch (Exception e) {
            SetTextOnUIThread("Error");
        }
    }

    private void UnInitScanner() {
        if(mis100!=null)
            //isCaptureRunning=true;
            try {
                int ret = mis100.UnInit();
                if (ret != 0) {
                    SetTextOnUIThread(mis100.GetErrorMsg(ret));
                } else {
                    SetLogOnUIThread("Uninit Success");
                    SetTextOnUIThread("Uninit Success");
                }
            } catch (Exception e) {
                Log.e("UnInitScanner.EX", e.toString());
            }
    }

    private void DisplayIris(final Bitmap bitmap) {
        imgIris.post(new Runnable() {
            @Override
            public void  run() {
                imgIris.setImageBitmap(bitmap);
            }
        });
    }

    private void WriteFile(String filename, byte[] bytes) {
        try {
            String path = Environment.getExternalStorageDirectory()
                    + "//IrisData";
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
        } catch (Exception e1) {
            e1.printStackTrace();
        }
    }

    private void ClearLog() {
        txtEventLog.post(new Runnable() {
            public void run() {
                txtEventLog.setText("", TextView.BufferType.EDITABLE);
            }
        });
    }

    private void SetTextOnUIThread(final String str) {

//        lblMessage.post(new Runnable() {
//            public void run() {
//                lblMessage.setText(str);
//            }
//        });
    }

    private void SetLogOnUIThread(final String str) {

        txtEventLog.post(new Runnable() {
            public void run() {
                txtEventLog.append("\n" + str);
            }
        });
    }

    public void SetData2(IrisData irisData) {
        if (scannerAction.equals(ScannerAction.Capture)) {
            Enroll_Template = new byte[irisData.ISOTemplate().length];
            System.arraycopy(irisData.ISOTemplate(), 0, Enroll_Template, 0,
                    irisData.ISOTemplate().length);
        }

        WriteFile("Raw.raw", irisData.RawData());
        WriteFile("K7.bmp", irisData.K7Image());
        WriteFile("Iris.bmp", irisData.IRISImage());
        WriteFile("ISOTemplate.iso", irisData.ISOTemplate());
    }

    @Override
    public void OnDeviceAttached(final int vid, final int pid, boolean hasPermission) {
        if (!hasPermission) {
            SetTextOnUIThread("Permission denied");
            return;
        }
        new Thread(new Runnable() {
            @Override
            public void run() {
                if (vid == 11279 && pid == 8448) {
                    InitScanner();
                }
            }
        }).start();
    }

    private void showSuccessLog() {
        SetTextOnUIThread("Init success");
        String info = "Serial: "
                + mis100.GetDeviceInfo().SerialNo() + "\nMake: "
                + mis100.GetDeviceInfo().Make() + "\nModel: "
                + mis100.GetDeviceInfo().Model() + "\nWidth: "
                + mis100.GetDeviceInfo().Width() + "\nHeight: "
                + mis100.GetDeviceInfo().Height()
                + "\nCertificate: " + mis100.GetCertification();
        SetLogOnUIThread(info);
    }

    @Override
    public void OnDeviceDetached() {
        UnInitScanner();
        SetTextOnUIThread("Device removed");
    }

    @Override
    public void OnHostCheckFailed(String err) {
        try {
            SetLogOnUIThread(err);
            Toast.makeText(this, err, Toast.LENGTH_LONG).show();
        } catch (Exception ignored) {
        }
    }

    @Override
    public void OnMIS100AutoCaptureCallback(int ErrorCode, int Quality, byte[] irisImage) {
        if (ErrorCode != 0) {
            SetTextOnUIThread("Err :: " + ErrorCode + " (" + mis100.GetErrorMsg(ErrorCode) + ")");
            return;
        }
        SetTextOnUIThread("Quality :: " + Quality);
        final Bitmap bmp = BitmapFactory.decodeByteArray(irisImage, 0, irisImage.length);
        imgIris.post(new Runnable() {
            @Override
            public void run() {
                imgIris.setImageBitmap(bmp);
            }
        });
    }
}
